Pod::Spec.new do |s|
  s.name             = 'FluentAdFlowRNBridge'
  s.version          = '4.1.1-beta.1'
  s.summary          = 'Fluent AdFlow React Native bridge (new arch, pre-built)'
  s.description      = 'Pre-built xcframework for React Native 0.81.x. Use the git tag matching your RN minor version.'
  s.homepage         = 'https://github.com/FluentCo/Fluent-AdFlow-RN-Package.git'
  s.license          = { :type => 'Copyright 2023 Fluent', :text => <<-LICENSE
    Licensed under the Fluent Software Development Kit (SDK) Terms of Use Version 1.0 (the "License")
    LICENSE
  }
  s.author           = { 'fluent' => 'fluentco.com' }
  s.source           = { :http => 'https://mobile-sdk.adflow-prod.minionplatform.com/ios-rn/v4.1.1-beta.1-rn0.81/FluentAdFlowBridge.xcframework.4.1.1-beta.1-rn0.81.zip' }
  s.ios.deployment_target = '15.1'
  s.swift_version    = '5.8'
  s.vendored_frameworks = 'FluentAdFlowRNBridge.xcframework'
end
