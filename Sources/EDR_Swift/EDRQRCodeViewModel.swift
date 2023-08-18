import SwiftUI

@available(iOS 16.0, *)
public class EDRQRCodeViewModel: ObservableObject {
  @Published var renderer: Renderer

  public init(
    qrCodeTextContent: String,
    imageRenderSize: CGSize
  ) {
    self.renderer = Renderer(imageProvider: { (scaleFactor: CGFloat, headroom: CGFloat) -> CIImage? in
      guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else {
        return nil
      }

      let inputData = qrCodeTextContent.data(using: .utf8)
      qrFilter.setValue(inputData, forKey: "inputMessage")
      qrFilter.setValue("H", forKey: "inputCorrectionLevel")

      guard var image = qrFilter.outputImage else { return nil }

      let sizeTransform = CGAffineTransform(
        scaleX: imageRenderSize.width * (scaleFactor / image.extent.size.width),
        y:  imageRenderSize.height * (scaleFactor / image.extent.size.height)
      )

      image = image.transformed(by: sizeTransform)

      let maxRGB = headroom
      guard let colorSpace = CGColorSpace(name: CGColorSpace.extendedLinearSRGB),
            let maxFillColor = CIColor(red: maxRGB, green: maxRGB, blue: maxRGB, colorSpace: colorSpace) else {
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
          width: imageRenderSize.width * scaleFactor,
          height: imageRenderSize.height * scaleFactor
        )
      )
    })
  }
}
