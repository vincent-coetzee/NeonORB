// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Neon",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Neon",
            targets: ["Neon"]),
    ],
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/BlueSocket.git", from: "1.0.16"),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.7.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Neon",
            dependencies: ["HeliumLogger","Socket"]),
        .testTarget(
            name: "NeonTests",
            dependencies: ["Neon"]),
    ]
)
