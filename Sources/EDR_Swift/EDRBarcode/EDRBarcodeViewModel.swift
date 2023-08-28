import SwiftUI

public class EDRBarcodeViewModel: ObservableObject {
  @Published var renderer: Renderer

  public init(content: String, size: CGSize) {
    renderer = Renderer(imageProvider: { (scaleFactor: CGFloat, headroom: CGFloat) -> CIImage? in
      guard var image: CIImage = BarcodeGenerator.generate(from: content) else { return nil }

      let sizeTransform = CGAffineTransform(
        scaleX: size.width * (scaleFactor / image.extent.size.width),
        y:  size.height * (scaleFactor / image.extent.size.height)
      )
      image = image.transformed(by: sizeTransform)
      
      guard let colorSpace = CGColorSpace(name: CGColorSpace.extendedLinearSRGB),
            let maxFillColor = CIColor(red: headroom, green: headroom, blue: headroom, colorSpace: colorSpace) else {
        return nil
      }

      let fillImage = CIImage(color: maxFillColor)
      let maskFilter = CIFilter.blendWithMask()
      maskFilter.maskImage = image
      maskFilter.inputImage = fillImage

      return maskFilter.outputImage?.cropped(
        to: CGRect(
          x: 0,
          y: 0,
          width: size.width * scaleFactor,
          height: size.height * scaleFactor
        )
      )
    })
  }
}
