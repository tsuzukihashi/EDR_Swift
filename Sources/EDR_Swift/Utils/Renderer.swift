import Metal
import MetalKit
import CoreImage

@available(iOS 16.0, *)
public final class Renderer: NSObject, ObservableObject {
  public let device: MTLDevice? = MTLCreateSystemDefaultDevice()
  private let commandQueue: MTLCommandQueue?
  private let renderContext: CIContext?
  private let renderQueue = DispatchSemaphore(value: 3)

  private let imageProvider: (_ contentScaleFactor: CGFloat, _ headroom: CGFloat) -> CIImage?

  public init(imageProvider: @escaping (_ contentScaleFactor: CGFloat, _ headroom: CGFloat) -> CIImage?) {
    self.imageProvider = imageProvider
    self.commandQueue = self.device?.makeCommandQueue()
    if let commandQueue {
      self.renderContext = CIContext(
        mtlCommandQueue: commandQueue,
        options: [
          .name: "Renderer",
          .cacheIntermediates: true,
          .allowLowPower: true
        ]
      )
    } else {
      self.renderContext = nil
    }
    super.init()
  }
}

extension Renderer: MTKViewDelegate {
  public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}

  public func draw(in view: MTKView) {
    guard let commandQueue, let renderContext else { return }
    _ = renderQueue.wait(timeout: DispatchTime.distantFuture)

    guard let commandBuffer = commandQueue.makeCommandBuffer() else { return }
    commandBuffer.addCompletedHandler { [weak self] _ in
      self?.renderQueue.signal()
    }

    guard let drawable = view.currentDrawable else { return }
    let drawSize = view.drawableSize
    let contentScaleFactor = view.contentScaleFactor

    let destination = CIRenderDestination(
      width: Int(drawSize.width),
      height: Int(drawSize.height),
      pixelFormat: view.colorPixelFormat,
      commandBuffer: commandBuffer,
      mtlTextureProvider: { () -> MTLTexture in
        return drawable.texture
      }
    )

    let headroom: CGFloat = view.window?.screen.currentEDRHeadroom ?? 1.0
    guard var image = self.imageProvider(contentScaleFactor, headroom) else { return }
    let iRect = image.extent
    let backBounds = CGRect(
      x: 0,
      y: 0,
      width: drawSize.width,
      height: drawSize.height
    )
    let shiftX = round((backBounds.size.width + iRect.origin.x - iRect.size.width) * 0.5)
    let shiftY = round((backBounds.size.height + iRect.origin.y - iRect.size.height) * 0.5)

    image = image.transformed(by: CGAffineTransform(translationX: shiftX, y: shiftY))
    image = image.composited(over: .gray)

    _ = try? renderContext.startTask(
      toRender: image,
      from: backBounds,
      to: destination,
      at: .zero
    )

    commandBuffer.present(drawable)
    commandBuffer.commit()
  }
}
