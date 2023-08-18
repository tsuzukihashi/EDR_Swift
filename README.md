# EDR_Swift
EDR stands for Extended Dynamic Range.
It is one of Apple's HDR technologies called Extended Dynamic Range

<img src="https://github.com/tsuzukihashi/EDR_Swift/assets/19743978/0d2a90ad-5eb2-4a62-aba5-0fbf6eb90239" width=320>

# Usage


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
      qrCodeTextContent: "https://bento.me/tsuzuki817",
      imageRenderSize: .init(width: 300, height: 300)
    )
    .frame(width: 300, height: 300)
  }
}
```
<img src="https://github.com/tsuzukihashi/EDR_Swift/assets/19743978/c3c6b573-ed0e-44ec-affe-f203185d6dc2" width=320>
