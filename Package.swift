// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SwiftBits",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "SwiftBits", targets: ["SwiftBits"])
    ],
    targets: [
        .target(
            name: "SwiftBits",
            resources: [.process("Resources")]
        ),
        .testTarget(name: "SwiftBitsTests", dependencies: ["SwiftBits"])
    ]
)
