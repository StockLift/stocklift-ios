// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StockLiftSDK",
    platforms: [
      // Only add support for iOS 14 and up.
      .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "StockLiftSDK",
            targets: ["StockLiftSDK"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(
            name: "LinkKit",
            url: "https://github.com/plaid/plaid-link-ios",
            .upToNextMajor(from: "3.0.0")
          ),
        .package(
            name: "Kingfisher",
            url: "https://github.com/onevcat/Kingfisher",
            .upToNextMajor(from: "7.0.0")
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "StockLiftSDK",
            dependencies: [
                .product(name: "LinkKit", package: "LinkKit"),
                .product(name: "Kingfisher", package: "Kingfisher")
            ],
            path: "Sources",
            resources: [
                .process("Resources")
            ]),
        
        .testTarget(
            name: "StockLiftSDKTests",
            dependencies: ["StockLiftSDK"]
        ),
    ]
)
