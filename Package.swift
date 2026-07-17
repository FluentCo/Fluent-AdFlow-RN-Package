// swift-tools-version: 5.9
// ============================================================
// Fluent-AdFlow-RN-Package
//
// Swift Package Manager distribution of the Fluent AdFlow
// React Native bridge for iOS.
//
// This package ships a pre-built XCFramework so consumers
// need no CocoaPods, no pod install, and no source compilation.
//
// Usage in Xcode:
//   File → Add Package Dependencies...
//   https://github.com/FluentCo/Fluent-AdFlow-RN-Package
//
// npm package (JS layer — always required):
//   npm install @npm_fluentco/adflow-react-native-sdk
//
// react-native.config.js (disable CocoaPods autolinking for iOS):
//   module.exports = {
//     dependencies: {
//       '@npm_fluentco/adflow-react-native-sdk': {
//         platforms: { ios: null },
//       },
//     },
//   };
// ============================================================

import PackageDescription

// ── Update both values on every release ──────────────────────
let version  = "4.0.0-beta.2"
let checksum = "REPLACE_WITH_SHA256_FROM_build-xcframework.sh"
// ─────────────────────────────────────────────────────────────

let s3Base = "https://mobile-sdk.adflow-prod.minionplatform.com/ios-rn"
let zipName = "FluentAdFlowBridge.xcframework.\(version).zip"

let package = Package(
    name: "FluentAdFlowRNBridge",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "FluentAdFlowRNBridge",
            targets: ["FluentAdFlowRNBridge"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "FluentAdFlowRNBridge",
            url: "\(s3Base)/v\(version)/\(zipName)",
            checksum: checksum
        ),
    ]
)
