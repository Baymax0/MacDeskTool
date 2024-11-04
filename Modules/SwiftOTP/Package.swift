// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SwiftOTP",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "SwiftOTP", targets: ["SwiftOTP"])
    ],
    dependencies: [
        .package(name: "Crypto", path: "../swift-crypto")
    ],
    targets: [
        .target(
            name: "SwiftOTP", 
            dependencies: ["Crypto"], 
            path: "SwiftOTP"
        )
    ]
)
