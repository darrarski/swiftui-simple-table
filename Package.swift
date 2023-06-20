// swift-tools-version: 5.8
import PackageDescription

let package = Package(
  name: "swiftui-simple-table",
  platforms: [
    .iOS(.v16),
    .macOS(.v13),
  ],
  products: [
    .library(name: "SimpleTable", targets: ["SimpleTable"]),
    .library(name: "SimpleTableExamples", targets: ["SimpleTableExamples"]),
  ],
  targets: [
    .target(
      name: "SimpleTable"
    ),
    .target(
      name: "SimpleTableExamples",
      dependencies: [
        .target(name: "SimpleTable"),
      ]
    ),
  ]
)

for target in package.targets {
  target.swiftSettings = target.swiftSettings ?? []
  target.swiftSettings?.append(
    .unsafeFlags(
      [
        //"-Xfrontend", "-strict-concurrency=targeted",
        //"-Xfrontend", "-enable-actor-data-race-checks",
        //"-Xfrontend", "-debug-time-function-bodies",
        //"-Xfrontend", "-debug-time-expression-type-checking",
        //"-enable-library-evolution",
      ], .when(configuration: .debug))
  )
}
