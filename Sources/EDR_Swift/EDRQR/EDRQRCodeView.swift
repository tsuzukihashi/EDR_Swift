import SwiftUI

@available(iOS 16.0, *)
public struct EDRQRCodeView: View {
  @StateObject var viewModel: EDRQRCodeViewModel

  public init(content: String, size: CGSize) {
    _viewModel = StateObject(
      wrappedValue: .init(
        content: content,
        size: size
      )
    )
  }

  public var body: some View {
    MetalKitView(renderer: viewModel.renderer)
  }
}
