// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Encryptor",
    dependencies: [
        .package(
            name: "Files",
            url: "https://github.com/johnsundell/files.git",
            from: "4.0.0"
        )
    ],
    targets: [
        .target(
            name: "Encryptor",
            dependencies: ["EncryptorCore"]),
        .target(
            name: "EncryptorCore",
            dependencies: ["Files"])
    ]
)
