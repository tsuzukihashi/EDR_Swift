import SwiftUI

public struct EDRBarcodeView: View {
  @StateObject var viewModel: EDRBarcodeViewModel

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

