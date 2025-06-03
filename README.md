# ColorHex

[![Swift](https://img.shields.io/badge/Swift-5.10+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20visionOS-lightgrey.svg)](https://developer.apple.com)
[![CI](https://github.com/edgeengineer/color-hex/workflows/CI/badge.svg)](https://github.com/edgeengineer/color-hex/actions)
[![codecov](https://codecov.io/gh/edgeengineer/color-hex/branch/main/graph/badge.svg)](https://codecov.io/gh/edgeengineer/color-hex)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Release](https://img.shields.io/github/v/release/edgeengineer/color-hex)](https://github.com/edgeengineer/color-hex/releases)

A Swift Package for converting between hex color strings and native Apple platform color types (`UIColor`, `NSColor`, and SwiftUI `Color`).

## Supported Platforms

- **iOS 14.0+** ![iOS](https://img.shields.io/badge/iOS-14.0+-blue.svg)
- **macOS 11.0+** ![macOS](https://img.shields.io/badge/macOS-11.0+-blue.svg)
- **tvOS 14.0+** ![tvOS](https://img.shields.io/badge/tvOS-14.0+-blue.svg)
- **watchOS 7.0+** ![watchOS](https://img.shields.io/badge/watchOS-7.0+-blue.svg)
- **visionOS 1.0+** ![visionOS](https://img.shields.io/badge/visionOS-1.0+-blue.svg)

## Features

- ✅ Convert hex strings to native color objects
- ✅ Convert native color objects to hex strings
- ✅ Support for 3, 4, 6, and 8 character hex formats
- ✅ Alpha channel support
- ✅ Optional (`?`) and throwing APIs
- ✅ Automatic `#` prefix handling
- ✅ Swift 6 compatibility
- ✅ Comprehensive test coverage

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/edgeengineer/color-hex.git", from: "0.0.1")
]
```

Or add it through Xcode: **File** → **Add Package Dependencies** → Enter the repository URL.

## Usage

### Basic Usage

```swift
import ColorHex

// Create HexColor from string
let hexColor = HexColor(hex: "#FF0000")  // Optional initializer
let hexColor2 = try HexColor(throwingHex: "#FF0000")  // Throwing initializer

// Convert to hex string
let hexString = hexColor?.hexString()  // "#FF0000"
let hexStringWithAlpha = hexColor?.hexString(includeAlpha: true)  // "#FF0000FF"
```

### String Extensions

```swift
import ColorHex

// Optional API
let color = "#FF0000".hexColor()

// Throwing API
let color2 = try "#FF0000".throwingHexColor()
```

### UIKit Integration

```swift
import UIKit
import ColorHex

// Create UIColor from hex
let redColor = UIColor(hex: "#FF0000")

// Convert UIColor to hex
let uiColor = UIColor.red
let hexString = uiColor.hexString  // "#FF0000"
let hexColor = uiColor.hexColor
```

### AppKit Integration

```swift
import AppKit
import ColorHex

// Create NSColor from hex
let redColor = NSColor(hex: "#FF0000")

// Convert NSColor to hex
let nsColor = NSColor.red
let hexString = nsColor.hexString  // "#FF0000"
let hexColor = nsColor.hexColor
```

### SwiftUI Integration

```swift
import SwiftUI
import ColorHex

// Create SwiftUI Color from hex
let redColor = Color(hex: "#FF0000")

// Convert SwiftUI Color to hex
let color = Color.red
let hexString = color.hexString  // "#FF0000"
let hexColor = color.hexColor
```

## Supported Hex Formats

| Format | Example | Description |
|--------|---------|-------------|
| RGB (3 digits) | `#F0F` | Short form, expanded to `#FF00FF` |
| RGBA (4 digits) | `#F0FA` | Short form with alpha |
| RGB (6 digits) | `#FF00FF` | Standard RGB format |
| RGBA (8 digits) | `#FF00FFAA` | RGB with alpha channel |

All formats support optional `#` prefix and are case-insensitive.

## Error Handling

The throwing API provides specific error types:

```swift
do {
    let color = try HexColor(throwingHex: "invalid")
} catch HexColorError.invalidCharacters {
    print("Contains non-hex characters")
} catch HexColorError.invalidLength {
    print("Invalid length (must be 3, 4, 6, or 8 characters)")
} catch HexColorError.invalidFormat {
    print("Invalid format")
}
```

## Requirements

- Swift 5.10+
- Xcode 15.0+

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.