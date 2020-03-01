// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Blanket",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(name: "BlanketKit", targets: ["BlanketKit"]),
    .library(name: "BlanketCLI", targets: ["BlanketCLI"]),
    .executable(name: "blanket", targets: ["Blanket"])
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(url: "https://github.com/cfilipov/TextTable.git", .branch("master")),
    .package(url: "https://github.com/apple/swift-argument-parser.git", .branch("master"))
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "BlanketKit",
      dependencies: ["TextTable"]),
    .testTarget(
      name: "BlanketKitTests",
      dependencies: ["BlanketKit"]),
    .target(
      name: "BlanketCLI",
      dependencies: ["BlanketKit", "ArgumentParser"]),
    .testTarget(
      name: "BlanketCLITests",
      dependencies: ["BlanketCLI", "ArgumentParser"]),
    .target(
      name: "Blanket",
      dependencies: ["BlanketCLI"]),
    .testTarget(
      name: "BlanketTests",
      dependencies: []
    )
  ]
)
