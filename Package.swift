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

// ── Update all values on every release ──────────────────────
let version       = "4.1.1-beta.2"
let rnMinor       = "79"  // short minor only; full form is 0.79
let checksum      = "aca0cd088daf92e7cb56814b9ff50ad937cba0ac790c35aa36d5065f14d1c6dd"
let debugChecksum = "650640f68d422655bf55375425a9991ac66cb1290503d8200dfb7417dedf069f"
// ─────────────────────────────────────────────────────────────

let s3Base    = "https://mobile-sdk.adflow-prod.minionplatform.com/ios-rn"
let s3Dir     = "4.1.1-beta.2.rn79"  // matches GIT_TAG and S3 upload directory
let zipName   = "FluentAdFlowBridge.xcframework.4.1.1-beta.2.rn79.zip"
let debugZipName = "FluentAdFlowBridge.debug.xcframework.4.1.1-beta.2.rn79.zip"

let package = Package(
    name: "FluentAdFlowRNBridge",
    platforms: [.iOS(.v16)],
    products: [
        // Release xcframework — use for production / App Store builds.
        .library(
            name: "FluentAdFlowRNBridge",
            targets: ["FluentAdFlowRNBridge"]
        ),
        // Debug xcframework — use during development to avoid Debug/Release ShadowNode layout mismatch.
        .library(
            name: "FluentAdFlowRNBridgeDebug",
            targets: ["FluentAdFlowRNBridgeDebug"]
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
        // Release xcframework — compiled with NDEBUG, matches Release host app ShadowNode layout.
        .binaryTarget(
            name: "FluentAdFlowBridge",
            url: "\(s3Base)/\(s3Dir)/\(zipName)",
            checksum: checksum
        ),
        // Debug xcframework — compiled without NDEBUG, matches Debug host app ShadowNode layout.
        .binaryTarget(
            name: "FluentAdFlowBridgeDebug",
            url: "\(s3Base)/\(s3Dir)/\(debugZipName)",
            checksum: debugChecksum
        ),

        .target(
            name: "FluentAdFlowRNBridge",
            dependencies: [
                .target(name: "FluentAdFlowBridge"),
                .product(name: "FluentAdFlowAdsWidget", package: "Fluent-AdFlow-Widget-Package"),
            ],
            path: "Sources/FluentAdFlowRNBridge"
        ),
        .target(
            name: "FluentAdFlowRNBridgeDebug",
            dependencies: [
                .target(name: "FluentAdFlowBridgeDebug"),
                .product(name: "FluentAdFlowAdsWidget", package: "Fluent-AdFlow-Widget-Package"),
            ],
            path: "Sources/FluentAdFlowRNBridgeDebug"
        ),
    ]
)
