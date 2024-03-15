
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "libprisma",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v17),
    ],
    products: [
        .library(name: "libprisma", targets: ["libprisma"]),
    ],
    dependencies: [],
    targets: [
        .binaryTarget(name: "libprisma", url: "", checksum: "11bfa012cce3628eb215386a8734978844c8a28f7e31c2c70783adaacba19981")
    ]
)

