import Testing
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

@Suite("HexColor Tests")
struct HexColorTests {
    
    @Test("Basic hex color parsing - 6 digits")
    func testBasicHexColorParsing() {
        let color = HexColor(hex: "#FF0000")
        #expect(color != nil)
        #expect(color?.red == 1.0)
        #expect(color?.green == 0.0)
        #expect(color?.blue == 0.0)
        #expect(color?.alpha == 1.0)
    }
    
    @Test("Hex color parsing without # prefix")
    func testHexColorParsingWithoutPrefix() {
        let color = HexColor(hex: "00FF00")
        #expect(color != nil)
        #expect(color?.red == 0.0)
        #expect(color?.green == 1.0)
        #expect(color?.blue == 0.0)
        #expect(color?.alpha == 1.0)
    }
    
    @Test("3-digit hex color parsing")
    func testThreeDigitHexColorParsing() {
        let color = HexColor(hex: "#F0F")
        #expect(color != nil)
        #expect(abs(color!.red - 1.0) < 0.01)
        #expect(abs(color!.green - 0.0) < 0.01)
        #expect(abs(color!.blue - 1.0) < 0.01)
        #expect(color?.alpha == 1.0)
    }
    
    @Test("4-digit hex color parsing with alpha")
    func testFourDigitHexColorParsingWithAlpha() {
        let color = HexColor(hex: "#F00F")
        #expect(color != nil)
        #expect(abs(color!.red - 1.0) < 0.01)
        #expect(abs(color!.green - 0.0) < 0.01)
        #expect(abs(color!.blue - 0.0) < 0.01)
        #expect(abs(color!.alpha - 1.0) < 0.01)
    }
    
    @Test("8-digit hex color parsing with alpha")
    func testEightDigitHexColorParsingWithAlpha() {
        let color = HexColor(hex: "#FF000080")
        #expect(color != nil)
        #expect(color?.red == 1.0)
        #expect(color?.green == 0.0)
        #expect(color?.blue == 0.0)
        #expect(abs(color!.alpha - 0.5) < 0.01)
    }
    
    @Test("Invalid hex color parsing")
    func testInvalidHexColorParsing() {
        #expect(HexColor(hex: "invalid") == nil)
        #expect(HexColor(hex: "#GG0000") == nil)
        #expect(HexColor(hex: "#12345") == nil)
        #expect(HexColor(hex: "") == nil)
    }
    
    @Test("Throwable hex color parsing - valid")
    func testThrowableHexColorParsingValid() throws {
        let color = try HexColor(throwingHex: "#FF0000")
        #expect(color.red == 1.0)
        #expect(color.green == 0.0)
        #expect(color.blue == 0.0)
        #expect(color.alpha == 1.0)
    }
    
    @Test("Throwable hex color parsing - invalid characters")
    func testThrowableHexColorParsingInvalidCharacters() {
        #expect(throws: HexColorError.invalidCharacters) {
            try HexColor(throwingHex: "#GG0000")
        }
    }
    
    @Test("Throwable hex color parsing - invalid length")
    func testThrowableHexColorParsingInvalidLength() {
        #expect(throws: HexColorError.invalidLength) {
            try HexColor(throwingHex: "#12345")
        }
    }
    
    @Test("Throwable hex color parsing - invalid format")
    func testThrowableHexColorParsingInvalidFormat() {
        #expect(throws: HexColorError.invalidFormat) {
            try HexColor(throwingHex: "")
        }
    }
    
    @Test("Hex string generation")
    func testHexStringGeneration() {
        let color = HexColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        #expect(color.hexString() == "#FF0000")
        #expect(color.hexString(includeAlpha: true) == "#FF0000FF")
    }
    
    @Test("Hex string generation with alpha")
    func testHexStringGenerationWithAlpha() {
        let color = HexColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
        #expect(color.hexString() == "#FF00007F")
        #expect(color.hexString(includeAlpha: true) == "#FF00007F")
    }
    
    @Test("String extension hex color")
    func testStringExtensionHexColor() {
        let color = "#FF0000".hexColor()
        #expect(color != nil)
        #expect(color?.red == 1.0)
        #expect(color?.green == 0.0)
        #expect(color?.blue == 0.0)
    }
    
    @Test("String extension throwable hex color")
    func testStringExtensionThrowableHexColor() throws {
        let color = try "#FF0000".throwingHexColor()
        #expect(color.red == 1.0)
        #expect(color.green == 0.0)
        #expect(color.blue == 0.0)
    }
}

#if canImport(UIKit)
@Suite("UIColor Tests")
struct UIColorTests {
    
    @Test("UIColor from hex")
    func testUIColorFromHex() {
        let color = UIColor(hex: "#FF0000")
        #expect(color != nil)
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        #expect(red == 1.0)
        #expect(green == 0.0)
        #expect(blue == 0.0)
        #expect(alpha == 1.0)
    }
    
    @Test("UIColor to hex string")
    func testUIColorToHexString() {
        let color = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        #expect(color.hexString == "#FF0000")
    }
    
    @Test("UIColor to hex color")
    func testUIColorToHexColor() {
        let color = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
        let hexColor = color.hexColor
        #expect(hexColor != nil)
        #expect(hexColor?.red == 1.0)
        #expect(hexColor?.green == 0.0)
        #expect(hexColor?.blue == 0.0)
        #expect(abs(hexColor!.alpha - 0.5) < 0.01)
    }
}
#endif

#if canImport(AppKit)
@Suite("NSColor Tests")
struct NSColorTests {
    
    @Test("NSColor from hex")
    func testNSColorFromHex() {
        let color = NSColor(hex: "#FF0000")
        #expect(color != nil)
        
        guard let rgbColor = color?.usingColorSpace(.sRGB) else {
            #expect(Bool(false), "Failed to convert to sRGB")
            return
        }
        
        #expect(rgbColor.redComponent == 1.0)
        #expect(rgbColor.greenComponent == 0.0)
        #expect(rgbColor.blueComponent == 0.0)
        #expect(rgbColor.alphaComponent == 1.0)
    }
    
    @Test("NSColor to hex string")
    func testNSColorToHexString() {
        let color = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        #expect(color.hexString == "#FF0000")
    }
    
    @Test("NSColor to hex color")
    func testNSColorToHexColor() {
        let color = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
        let hexColor = color.hexColor
        #expect(hexColor != nil)
        #expect(hexColor?.red == 1.0)
        #expect(hexColor?.green == 0.0)
        #expect(hexColor?.blue == 0.0)
        #expect(abs(hexColor!.alpha - 0.5) < 0.01)
    }
}
#endif

#if canImport(SwiftUI)
@Suite("SwiftUI Color Tests")
struct SwiftUIColorTests {
    
    @Test("SwiftUI Color from hex")
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    func testSwiftUIColorFromHex() {
        let color = Color(hex: "#FF0000")
        #expect(color != nil)
    }
    
    @Test("SwiftUI Color to hex string")
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    func testSwiftUIColorToHexString() {
        let color = Color.red
        let hexString = color.hexString
        #expect(hexString != nil)
        #expect(hexString?.hasPrefix("#") == true)
    }
    
    @Test("SwiftUI Color to hex color")
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    func testSwiftUIColorToHexColor() {
        let color = Color.red
        let hexColor = color.hexColor
        #expect(hexColor != nil)
    }
}
#endif