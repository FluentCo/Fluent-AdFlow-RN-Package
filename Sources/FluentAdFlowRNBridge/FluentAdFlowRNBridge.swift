// This file exists so SPM can resolve FluentAdFlowRNBridge as a library target.
// It aggregates two binary dependencies:
//   • FluentAdFlowBridge.xcframework   — the React Native iOS bridge
//   • fluentAdFlowAdsWidget.xcframework — the ad rendering engine
//
// Consumers only need to add Fluent-AdFlow-RN-Package once; both frameworks
// are resolved automatically as transitive dependencies.
