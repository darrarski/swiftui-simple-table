// swift-tools-version: 5.7
import PackageDescription

let package = Package(
  name: "swiftui-simple-table",
  platforms: [
    .iOS(.v16),
    .macOS(.v13),
  ],
  products: [
    .library(name: "SimpleTable", targets: ["SimpleTable"]),
  ],
  targets: [
    .target(name: "SimpleTable"),
  ]
)
