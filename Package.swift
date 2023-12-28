// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "FTAuth",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(name: "FTAuth", targets: ["FTAuth"])
    ],
    targets: [
        .target(name: "FTAuth", dependencies: [], path: "./FTAuthSources"),
    ]
)
