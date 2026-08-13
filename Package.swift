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
let version  = "4.1.1-beta.1"
let rnMinor  = "79"  // short minor only; full form is 0.79
let checksum = "0d03bdb0d795291f9a775df5bdc9407a39fc0a161a76f69f9e37a697116bba41"
// ─────────────────────────────────────────────────────────────

let s3Base = "https://mobile-sdk.adflow-prod.minionplatform.com/ios-rn"
let s3Dir    = "4.1.1-beta.1.rn79"  // matches GIT_TAG and S3 upload directory
let zipName  = "FluentAdFlowBridge.xcframework.4.1.1-beta.1.rn79.zip"

let package = Package(
    name: "FluentAdFlowRNBridge",
    platforms: [.iOS(.v16)],
    products: [
        // Consumers add this one product and get both the RN bridge
        // XCFramework and FluentAdFlowAdsWidget resolved automatically.
        .library(
            name: "FluentAdFlowRNBridge",
            targets: ["FluentAdFlowRNBridge"]
        ),
    ],
    dependencies: [
        // Provides FluentAdFlowAdsWidget.xcframework (required by the bridge).
        // Xcode resolves this transitively — consumers do NOT need to add it manually.
        .package(
            url: "https://github.com/FluentCo/Fluent-AdFlow-Widget-Package",
            from: "4.1.0"
        ),
    ],
    targets: [
        // Pre-built XCFramework (the React Native bridge).
        // Named with "Binary" suffix so the wrapper target can use "FluentAdFlowRNBridge".
        .binaryTarget(
            name: "FluentAdFlowBridge",
            url: "\(s3Base)/\(s3Dir)/\(zipName)",
            checksum: checksum
        ),

        // Thin wrapper that pulls in both the binary and FluentAdFlowAdsWidget.
        // SPM resolves both as transitive dependencies for any consumer.
        .target(
            name: "FluentAdFlowRNBridge",
            dependencies: [
                .target(name: "FluentAdFlowBridge"),
                .product(name: "FluentAdFlowAdsWidget", package: "Fluent-AdFlow-Widget-Package"),
            ],
            path: "Sources/FluentAdFlowRNBridge"
        ),
    ]
)
