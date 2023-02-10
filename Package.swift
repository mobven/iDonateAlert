// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iDonateAlert",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "iDonateAlert",
            targets: ["iDonateAlert"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "iDonateAlert",
            dependencies: [],
            resources: [
                .copy("Resources/ahbap.pdf")
            ]
        ),
        .testTarget(
            name: "iDonateAlertTests",
            dependencies: ["iDonateAlert"])
    ]
)
