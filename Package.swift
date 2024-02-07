// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "MovieAPI",

    platforms: [
        .macOS(.v13)
    ],

    products: [
        .executable(name: "App", targets: ["App"])
    ],

    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.89.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0"),
        .package(url: "https://github.com/adamayoung/TMDb.git", from: "11.0.0")
    ],

    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                "MovieAPI",
                "MovieWeb",
                "MovieDomain",
                "MovieData",
                .product(name: "Vapor", package: "vapor")
            ]
        ),
        .testTarget(
            name: "AppTests",
            dependencies: [
                .target(name: "App"),
                .product(name: "XCTVapor", package: "vapor"),
                .product(name: "Vapor", package: "vapor")
            ]
        ),

        .target(
            name: "MovieAPI",
            dependencies: [
                "MovieDomain",
                .product(name: "Vapor", package: "vapor")
            ]
        ),
        .testTarget(
            name: "MovieAPITests",
            dependencies: [
                .target(name: "MovieAPI"),
                .product(name: "XCTVapor", package: "vapor"),
                .product(name: "Vapor", package: "vapor")
            ]
        ),

        .target(
            name: "MovieWeb",
            dependencies: [
                "MovieDomain",
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Leaf", package: "leaf")
            ]
        ),
        .testTarget(
            name: "MovieWebTests",
            dependencies: [
                .target(name: "MovieWeb"),
                .product(name: "XCTVapor", package: "vapor"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Leaf", package: "leaf")
            ]
        ),

        .target(
            name: "MovieDomain"
        ),
        .testTarget(
            name: "MovieDomainTests",
            dependencies: [
                .target(name: "MovieDomain")
            ]
        ),

        .target(
            name: "MovieData",
            dependencies: [
                "MovieDomain",
                "TMDb"
            ]
        ),
        .testTarget(
            name: "MovieDataTests",
            dependencies: [
                "MovieData",
                "MovieDomain",
                "TMDb"
            ]
        )
    ]
)
