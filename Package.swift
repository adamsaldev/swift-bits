// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SwiftBits",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "SwiftBits", targets: ["SwiftBits"])
    ],
    targets: [
        .target(name: "SwiftBits"),
        .testTarget(name: "SwiftBitsTests", dependencies: ["SwiftBits"])
    ]
)
