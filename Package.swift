// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "movie-api",

    platforms: [
        .macOS(.v13)
    ],

    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.89.0")
    ],

    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                "API",
                .product(name: "Vapor", package: "vapor")
            ]
        ),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
            .product(name: "Vapor", package: "vapor")
        ]),

        .target(
            name: "API",
            dependencies: [
                .product(name: "Vapor", package: "vapor")
            ]
        ),
        .testTarget(name: "APITests", dependencies: [
            .target(name: "API"),
            .product(name: "XCTVapor", package: "vapor"),
            .product(name: "Vapor", package: "vapor")
        ])
    ]
)
