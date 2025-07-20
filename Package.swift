// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "HighlightKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "HighlightKit", targets: ["HighlightKit"]),
    ],
    targets: [
        .target(
            name: "HighlightKit",
            dependencies: [],
            path: "Sources"
        ),
    ]
)
