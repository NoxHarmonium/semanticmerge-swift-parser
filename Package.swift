import PackageDescription

let package = Package(
    name: "semanticmerge-swift-parser",
     dependencies: [
        .Package(url: "https://github.com/jpsim/SourceKitten.git", majorVersion: 0, minor: 16),
    ]
)
