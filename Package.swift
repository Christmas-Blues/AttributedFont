// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "AttributedFont",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(name: "AttributedFont", targets: ["AttributedFont", "Previews"])
    ],
    targets: [
        .target(name: "AttributedFont", dependencies: []),
        .target(name: "Previews", dependencies: ["AttributedFont"])
    ]
)
