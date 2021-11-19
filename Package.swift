// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HanoyTowersUI",
    platforms: [ .macOS(SupportedPlatform.MacOSVersion.v12), .iOS(.v15)],
    products: [
        .executable(
            name: "App",
            targets: ["App"])
    ],
    dependencies: [
        .package(url: "https://github.com/seadiem/HanoyTowers", .branch("master"))
    ],
    targets: [

        .target(
            name: "HanoyTowers",
            dependencies: [.product(name: "HanoyTowers", package: "HanoyTowers")]),
        .executableTarget(
            name: "App",
            dependencies: ["HanoyTowers"])
    ]
)
