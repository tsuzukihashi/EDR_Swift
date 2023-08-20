import CoreImage.CIFilterBuiltins
import class UIKit.UIImage

@available(iOS 16.0, *)
public enum BarcodeGenerator {
  public static func generate(from contents: String) -> UIImage? {
    let context = CIContext()
    let filter = CIFilter.code128BarcodeGenerator()
    filter.message = Data(contents.utf8)

    if let outputImage = filter.outputImage,
       let cgImage = context.createCGImage(
        outputImage,
        from: outputImage.extent
       ) {
      return UIImage(cgImage: cgImage)
    }

    return nil
  }

  public static func generate(from contents: String) -> CIImage? {
    let filter = CIFilter.code128BarcodeGenerator()
    filter.message = Data(contents.utf8)

    return filter.outputImage
  }
}
