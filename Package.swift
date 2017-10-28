import PackageDescription
let package = Package(
    name: "FreebieApi",
    targets: [
        Target(name: "App"),
        Target(name: "Run", dependencies: ["App"]),
        ],
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2),
        .Package(url: "https://github.com/vapor/fluent-provider.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/postgresql-provider.git", majorVersion: 2)
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        ]
)

//// swift-tools-version:4.0
//
//import PackageDescription
//
//let package = Package(
//    name: "FreebieApi",
//    products: [
//        .library(name: "App", targets: ["App"]),
//        .executable(name: "Run", targets: ["Run"])
//    ],
//    dependencies: [
//        .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "2.1.0")),
//        .package(url: "https://github.com/vapor/fluent-provider.git", .upToNextMajor(from: "1.2.0")),
//        .package(url: "https://github.com/vapor-community/postgresql-provider.git", .upToNextMajor(from: "2.1.0")),
//    ],
//    targets: [
//        .target(name: "App", dependencies: ["Vapor", "FluentProvider", "PostgreSQLProvider"],
//                exclude: [
//                    "Config",
//                    "Public",
//                    "Resources",
//                ]),
//        .target(name: "Run", dependencies: ["App"]),
//        .testTarget(name: "AppTests", dependencies: ["App", "Testing"])
//    ]
//)
//
