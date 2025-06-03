import Foundation

#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

#if canImport(SwiftUI)
import SwiftUI
#endif

public enum HexColorError: Error, LocalizedError {
    case invalidFormat
    case invalidCharacters
    case invalidLength
    
    public var errorDescription: String? {
        switch self {
        case .invalidFormat:
            return "Invalid hex color format"
        case .invalidCharacters:
            return "Hex color contains invalid characters"
        case .invalidLength:
            return "Hex color has invalid length (must be 3, 4, 6, or 8 characters)"
        }
    }
}

public extension String {
    func hexColor() -> HexColor? {
        return HexColor(hex: self)
    }
    
    func throwingHexColor() throws -> HexColor {
        return try HexColor(throwingHex: self)
    }
}

public struct HexColor {
    public let red: CGFloat
    public let green: CGFloat
    public let blue: CGFloat
    public let alpha: CGFloat
    
    public init?(hex: String) {
        do {
            let hexColor = try HexColor(throwingHex: hex)
            self = hexColor
        } catch {
            return nil
        }
    }
    
    public init(throwingHex: String) throws {
        let hexString = throwingHex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        
        guard !hexString.isEmpty else { throw HexColorError.invalidFormat }
        guard hexString.allSatisfy({ $0.isHexDigit }) else { throw HexColorError.invalidCharacters }
        
        let length = hexString.count
        var rgbValue: UInt64 = 0
        
        guard Scanner(string: hexString).scanHexInt64(&rgbValue) else { throw HexColorError.invalidFormat }
        
        switch length {
        case 3:
            let r = (rgbValue >> 8) & 0xF
            let g = (rgbValue >> 4) & 0xF
            let b = rgbValue & 0xF
            self.red = CGFloat(r * 17) / 255.0
            self.green = CGFloat(g * 17) / 255.0
            self.blue = CGFloat(b * 17) / 255.0
            self.alpha = 1.0
        case 4:
            let r = (rgbValue >> 12) & 0xF
            let g = (rgbValue >> 8) & 0xF
            let b = (rgbValue >> 4) & 0xF
            let a = rgbValue & 0xF
            self.red = CGFloat(r * 17) / 255.0
            self.green = CGFloat(g * 17) / 255.0
            self.blue = CGFloat(b * 17) / 255.0
            self.alpha = CGFloat(a * 17) / 255.0
        case 6:
            self.red = CGFloat((rgbValue >> 16) & 0xFF) / 255.0
            self.green = CGFloat((rgbValue >> 8) & 0xFF) / 255.0
            self.blue = CGFloat(rgbValue & 0xFF) / 255.0
            self.alpha = 1.0
        case 8:
            self.red = CGFloat((rgbValue >> 24) & 0xFF) / 255.0
            self.green = CGFloat((rgbValue >> 16) & 0xFF) / 255.0
            self.blue = CGFloat((rgbValue >> 8) & 0xFF) / 255.0
            self.alpha = CGFloat(rgbValue & 0xFF) / 255.0
        default:
            throw HexColorError.invalidLength
        }
    }
    
    public init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) {
        self.red = max(0, min(1, red))
        self.green = max(0, min(1, green))
        self.blue = max(0, min(1, blue))
        self.alpha = max(0, min(1, alpha))
    }
    
    public func hexString(includeAlpha: Bool = false) -> String {
        let r = Int(red * 255)
        let g = Int(green * 255)
        let b = Int(blue * 255)
        let a = Int(alpha * 255)
        
        if includeAlpha || alpha < 1.0 {
            return String(format: "#%02X%02X%02X%02X", r, g, b, a)
        } else {
            return String(format: "#%02X%02X%02X", r, g, b)
        }
    }
}

#if canImport(UIKit)
public extension UIColor {
    convenience init?(hex: String) {
        guard let hexColor = HexColor(hex: hex) else { return nil }
        self.init(red: hexColor.red, green: hexColor.green, blue: hexColor.blue, alpha: hexColor.alpha)
    }
    
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
        
        let hexColor = HexColor(red: red, green: green, blue: blue, alpha: alpha)
        return hexColor.hexString(includeAlpha: alpha < 1.0)
    }
    
    var hexColor: HexColor? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
        return HexColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
#endif

#if canImport(AppKit)
public extension NSColor {
    convenience init?(hex: String) {
        guard let hexColor = HexColor(hex: hex) else { return nil }
        self.init(red: hexColor.red, green: hexColor.green, blue: hexColor.blue, alpha: hexColor.alpha)
    }
    
    var hexString: String? {
        guard let rgbColor = usingColorSpace(.sRGB) else { return nil }
        
        let hexColor = HexColor(red: rgbColor.redComponent, green: rgbColor.greenComponent, blue: rgbColor.blueComponent, alpha: rgbColor.alphaComponent)
        return hexColor.hexString(includeAlpha: rgbColor.alphaComponent < 1.0)
    }
    
    var hexColor: HexColor? {
        guard let rgbColor = usingColorSpace(.sRGB) else { return nil }
        return HexColor(red: rgbColor.redComponent, green: rgbColor.greenComponent, blue: rgbColor.blueComponent, alpha: rgbColor.alphaComponent)
    }
}
#endif

#if canImport(SwiftUI)
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension Color {
    init?(hex: String) {
        guard let hexColor = HexColor(hex: hex) else { return nil }
        self.init(red: hexColor.red, green: hexColor.green, blue: hexColor.blue, opacity: hexColor.alpha)
    }
    
    #if canImport(UIKit)
    var hexString: String? {
        return UIColor(self).hexString
    }
    
    var hexColor: HexColor? {
        return UIColor(self).hexColor
    }
    #elseif canImport(AppKit)
    var hexString: String? {
        return NSColor(self).hexString
    }
    
    var hexColor: HexColor? {
        return NSColor(self).hexColor
    }
    #endif
}
#endif