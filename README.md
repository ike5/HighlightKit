# HighlightKit

**HighlightKit** is a lightweight, developer-friendly syntax highlighter written in Swift using `AttributedString`. Designed for use in SwiftUI apps on iOS 17+ and macOS 14+, HighlightKit makes it easy to display beautifully highlighted source code directly in your views.

---

## Features

- Auto language detection (Swift, Python, JavaScript, HTML, etc.)
- Light and dark mode themes
- Easy-to-use API with full `AttributedString` support
- Swift Package Manager integration
- macOS + iOS SwiftUI compatibility

---

## Installation

### Swift Package Manager (SPM)

1. Open your Xcode project.
2. Go to **File > Add Packages...**
3. Paste the repo URL: `https://github.com/ike5/HighlightKit.git`
4. Select the `main` branch.

> Requires: **Xcode 15+**, **iOS 17+**, **macOS 14+**

---

## Usage

### Basic Example

```swift
import HighlightKit
import SwiftUI

struct ContentView: View {
    let code = """
    func greet(name: String) {
        print("Hello, \\(name)!")
    }
    """

    var body: some View {
        ScrollView {
            Text(HighlightKitAPI.highlight(code))
        }
    }
}

Example with `colorScheme` (optional)

```swift
import HighlightKit
import SwiftUI

struct ContentView: View {
    let code = """
    func greet(name: String) {
        print("Hello, \\(name)!")
    }
    """

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView {
            Text(HighlightKitAPI.highlight(code, colorScheme: colorScheme))
                .font(.system(.body, design: .monospaced))
                .padding()
        }
    }
}
