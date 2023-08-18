import SwiftUI
import MetalKit

@available(iOS 16.0, *)
public struct MetalKitView: UIViewRepresentable {
  @StateObject public var renderer: Renderer

  public func makeUIView(context: Context) -> MTKView {
    let view = MTKView(frame: .zero, device: renderer.device)
    view.preferredFramesPerSecond = 10
    view.framebufferOnly = false
    view.delegate = renderer

    if let layer = view.layer as? CAMetalLayer {
      layer.wantsExtendedDynamicRangeContent = true
      layer.colorspace = CGColorSpace(
        name: CGColorSpace.extendedLinearDisplayP3
      )
      view.colorPixelFormat = MTLPixelFormat.rgba16Float
    }
    return view
  }

  public func updateUIView(_ view: MTKView, context: Context) {
    configure(view: view, using: renderer)
  }

  private func configure(view: MTKView, using renderer: Renderer) {
    view.delegate = renderer
  }
}
