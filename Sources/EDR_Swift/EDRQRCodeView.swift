import SwiftUI

@available(iOS 16.0, *)
public struct EDRQRCodeView: View {
  @StateObject var viewModel: EDRQRCodeViewModel

  init(qrCodeTextContent: String, imageRenderSize: CGSize) {
    _viewModel = StateObject(
      wrappedValue: .init(
        qrCodeTextContent: qrCodeTextContent,
        imageRenderSize: imageRenderSize
      )
    )
  }

  public var body: some View {
    MetalKitView(renderer: viewModel.renderer)
  }
}
