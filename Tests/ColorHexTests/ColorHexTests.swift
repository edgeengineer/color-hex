import XCTest
import Foundation
@testable import ColorHex

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

#if canImport(SwiftUI)
import SwiftUI
#endif

class HexColorTests: XCTestCase {
    
    func testBasicHexColorParsing() {
        let color = HexColor(hex: "#FF0000")
        XCTAssertNotNil(color)
        XCTAssertEqual(color?.red, 1.0)
        XCTAssertEqual(color?.green, 0.0)
        XCTAssertEqual(color?.blue, 0.0)
        XCTAssertEqual(color?.alpha, 1.0)
    }
    
    func testHexColorParsingWithoutPrefix() {
        let color = HexColor(hex: "00FF00")
        XCTAssertNotNil(color)
        XCTAssertEqual(color?.red, 0.0)
        XCTAssertEqual(color?.green, 1.0)
        XCTAssertEqual(color?.blue, 0.0)
        XCTAssertEqual(color?.alpha, 1.0)
    }
    
    func testThreeDigitHexColorParsing() {
        let color = HexColor(hex: "#F0F")
        XCTAssertNotNil(color)
        XCTAssertEqual(color!.red, 1.0, accuracy: 0.01)
        XCTAssertEqual(color!.green, 0.0, accuracy: 0.01)
        XCTAssertEqual(color!.blue, 1.0, accuracy: 0.01)
        XCTAssertEqual(color?.alpha, 1.0)
    }
    
    func testFourDigitHexColorParsingWithAlpha() {
        let color = HexColor(hex: "#F00F")
        XCTAssertNotNil(color)
        XCTAssertEqual(color!.red, 1.0, accuracy: 0.01)
        XCTAssertEqual(color!.green, 0.0, accuracy: 0.01)
        XCTAssertEqual(color!.blue, 0.0, accuracy: 0.01)
        XCTAssertEqual(color!.alpha, 1.0, accuracy: 0.01)
    }
    
    func testEightDigitHexColorParsingWithAlpha() {
        let color = HexColor(hex: "#FF000080")
        XCTAssertNotNil(color)
        XCTAssertEqual(color?.red, 1.0)
        XCTAssertEqual(color?.green, 0.0)
        XCTAssertEqual(color?.blue, 0.0)
        XCTAssertEqual(color!.alpha, 0.5, accuracy: 0.01)
    }
    
    func testInvalidHexColorParsing() {
        XCTAssertNil(HexColor(hex: "invalid"))
        XCTAssertNil(HexColor(hex: "#GG0000"))
        XCTAssertNil(HexColor(hex: "#12345"))
        XCTAssertNil(HexColor(hex: ""))
    }
    
    func testThrowableHexColorParsingValid() throws {
        let color = try HexColor(throwingHex: "#FF0000")
        XCTAssertEqual(color.red, 1.0)
        XCTAssertEqual(color.green, 0.0)
        XCTAssertEqual(color.blue, 0.0)
        XCTAssertEqual(color.alpha, 1.0)
    }
    
    func testThrowableHexColorParsingInvalidCharacters() {
        XCTAssertThrowsError(try HexColor(throwingHex: "#GG0000")) { error in
            XCTAssertEqual(error as? HexColorError, HexColorError.invalidCharacters)
        }
    }
    
    func testThrowableHexColorParsingInvalidLength() {
        XCTAssertThrowsError(try HexColor(throwingHex: "#12345")) { error in
            XCTAssertEqual(error as? HexColorError, HexColorError.invalidLength)
        }
    }
    
    func testThrowableHexColorParsingInvalidFormat() {
        XCTAssertThrowsError(try HexColor(throwingHex: "")) { error in
            XCTAssertEqual(error as? HexColorError, HexColorError.invalidFormat)
        }
    }
    
    func testHexStringGeneration() {
        let color = HexColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(color.hexString(), "#FF0000")
        XCTAssertEqual(color.hexString(includeAlpha: true), "#FF0000FF")
    }
    
    func testHexStringGenerationWithAlpha() {
        let color = HexColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
        XCTAssertEqual(color.hexString(), "#FF00007F")
        XCTAssertEqual(color.hexString(includeAlpha: true), "#FF00007F")
    }
    
    func testStringExtensionHexColor() {
        let color = "#FF0000".hexColor()
        XCTAssertNotNil(color)
        XCTAssertEqual(color?.red, 1.0)
        XCTAssertEqual(color?.green, 0.0)
        XCTAssertEqual(color?.blue, 0.0)
    }
    
    func testStringExtensionThrowableHexColor() throws {
        let color = try "#FF0000".throwingHexColor()
        XCTAssertEqual(color.red, 1.0)
        XCTAssertEqual(color.green, 0.0)
        XCTAssertEqual(color.blue, 0.0)
    }
}

#if canImport(UIKit)
class UIColorTests: XCTestCase {
    
    func testUIColorFromHex() {
        let color = UIColor(hex: "#FF0000")
        XCTAssertNotNil(color)
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        XCTAssertEqual(red, 1.0)
        XCTAssertEqual(green, 0.0)
        XCTAssertEqual(blue, 0.0)
        XCTAssertEqual(alpha, 1.0)
    }
    
    func testUIColorToHexString() {
        let color = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(color.hexString, "#FF0000")
    }
    
    func testUIColorToHexColor() {
        let color = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
        let hexColor = color.hexColor
        XCTAssertNotNil(hexColor)
        XCTAssertEqual(hexColor?.red, 1.0)
        XCTAssertEqual(hexColor?.green, 0.0)
        XCTAssertEqual(hexColor?.blue, 0.0)
        XCTAssertEqual(hexColor!.alpha, 0.5, accuracy: 0.01)
    }
}
#endif

#if canImport(AppKit)
class NSColorTests: XCTestCase {
    
    func testNSColorFromHex() {
        let color = NSColor(hex: "#FF0000")
        XCTAssertNotNil(color)
        
        guard let rgbColor = color?.usingColorSpace(.sRGB) else {
            XCTFail("Failed to convert to sRGB")
            return
        }
        
        XCTAssertEqual(rgbColor.redComponent, 1.0)
        XCTAssertEqual(rgbColor.greenComponent, 0.0)
        XCTAssertEqual(rgbColor.blueComponent, 0.0)
        XCTAssertEqual(rgbColor.alphaComponent, 1.0)
    }
    
    func testNSColorToHexString() {
        let color = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(color.hexString, "#FF0000")
    }
    
    func testNSColorToHexColor() {
        let color = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
        let hexColor = color.hexColor
        XCTAssertNotNil(hexColor)
        XCTAssertEqual(hexColor?.red, 1.0)
        XCTAssertEqual(hexColor?.green, 0.0)
        XCTAssertEqual(hexColor?.blue, 0.0)
        XCTAssertEqual(hexColor!.alpha, 0.5, accuracy: 0.01)
    }
}
#endif

#if canImport(SwiftUI)
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
class SwiftUIColorTests: XCTestCase {
    
    func testSwiftUIColorFromHex() {
        let color = Color(hex: "#FF0000")
        XCTAssertNotNil(color)
    }
    
    func testSwiftUIColorToHexString() {
        let color = Color.red
        let hexString = color.hexString
        XCTAssertNotNil(hexString)
        XCTAssertTrue(hexString?.hasPrefix("#") == true)
    }
    
    func testSwiftUIColorToHexColor() {
        let color = Color.red
        let hexColor = color.hexColor
        XCTAssertNotNil(hexColor)
    }
}
#endif