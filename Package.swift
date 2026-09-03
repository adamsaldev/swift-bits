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
    dependencies: [
        .package(url: "https://github.com/nalexn/ViewInspector.git", from: "0.10.0")
    ],
    targets: [
        .target(
            name: "SwiftBits",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "SwiftBitsTests",
            dependencies: [
                "SwiftBits",
                "ViewInspector"
            ]
        )
    ]
)
