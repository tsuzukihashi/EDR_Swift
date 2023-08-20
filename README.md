# EDR_Swift
EDR stands for Extended Dynamic Range.
It is one of Apple's HDR technologies called Extended Dynamic Range

Note! EDR is for iOS 16 and above.

| QR | Barcode |
| -- | -- |
| <img src="https://github.com/tsuzukihashi/EDR_Swift/assets/19743978/d334dc02-89dc-40e4-97f6-a69491a9d71c" width=320> | <img src="https://github.com/tsuzukihashi/EDR_Swift/assets/19743978/29b3ea47-5042-4946-84a3-229294b13d24" width=320> |

# Usage

## Add Package Dependencies
<img width="835" alt="スクリーンショット 2023-08-19 0 34 25" src="https://github.com/tsuzukihashi/EDR_Swift/assets/19743978/d66d22d9-2cfc-47f9-90d5-8244c9af3b0b">


## EDRQRCodeView

```swift
import SwiftUI
/** import */
import EDR_Swift

struct ContentView: View {
  var body: some View {
    /** Set
      - QRContents
      - Size
     */
    EDRQRCodeView(
      content: "https://bento.me/tsuzuki817",
      size: .init(width: 300, height: 300)
    )
    .frame(width: 300, height: 300)
  }
}
```
<img src="https://github.com/tsuzukihashi/EDR_Swift/assets/19743978/c3c6b573-ed0e-44ec-affe-f203185d6dc2" width=320>


## EDRBarcodeCodeView

```swift
import SwiftUI
/** import */
import EDR_Swift

struct ContentView: View {
  var body: some View {
    EDRBarcodeView(
      content: "https://bento.me/tsuzuki817",
      size: .init(width: 320, height: 100)
    )
    .frame(width: 320, height: 100)
  }
}
```
<img src="https://github.com/tsuzukihashi/EDR_Swift/assets/19743978/6f917b23-aee0-4e7a-8e72-9d92e60eb616" width=320>
