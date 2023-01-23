// swift-tools-version: 5.7
import PackageDescription

let swiftSettings: [SwiftSetting] = [
  //.unsafeFlags(["-Xfrontend", "-warn-concurrency"], .when(configuration: .debug)),
  //.unsafeFlags(["-Xfrontend", "-strict-concurrency=complete"], .when(configuration: .debug)),
  //.unsafeFlags(["-Xfrontend", "-debug-time-function-bodies"], .when(configuration: .debug)),
  //.unsafeFlags(["-Xfrontend", "-debug-time-expression-type-checking"], .when(configuration: .debug)),
]

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
    .target(
      name: "SimpleTable",
      swiftSettings: swiftSettings
    ),
  ]
)
