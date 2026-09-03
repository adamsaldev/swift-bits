// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SwiftBits",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "SwiftBits", targets: ["SwiftBits"]),
        .executable(name: "SwiftBitsDemo", targets: ["SwiftBitsDemo"])
    ],
    targets: [
        .target(name: "SwiftBits"),
        .executableTarget(name: "SwiftBitsDemo", dependencies: ["SwiftBits"], path: "Examples/SwiftBitsDemo"),
        .testTarget(name: "SwiftBitsTests", dependencies: ["SwiftBits"])
    ]
)
