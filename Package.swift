// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "ColorHex",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "ColorHex",
            targets: ["ColorHex"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ColorHex",
            dependencies: []
        ),
        .testTarget(
            name: "ColorHexTests",
            dependencies: ["ColorHex"]
        ),
    ],
    swiftLanguageModes: [.v6]
)