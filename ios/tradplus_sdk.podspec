#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `s.dependency lib lint tradplus_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
s.name = 'tradplus_sdk'
s.version = '1.1.6'
s.summary = 'A new Flutter project.'
s.description = <<-DESC
Tradplus SDK Flutter project.
DESC
s.homepage = 'http://example.com'
s.license = { :file => '../LICENSE' }
s.author = { 'Your Company' => 'email@example.com' }
s.source = { :path => '.' }
s.source_files = 'Classes/**/*'
s.public_header_files = 'Classes/**/*.h'
s.dependency 'Flutter'
s.platform = :ios, '12.0'


s.static_framework = true


s.frameworks = 'NetworkExtension','DeviceCheck'


s.pod_target_xcconfig = {'OTHER_LDFLAGS' => ['-lObjC']}


s.libraries = 'c++', 'z', 'sqlite3', 'xml2', 'resolv', 'bz2.1.0','bz2','xml2','resolv.9','iconv','c++abi'


s.vendored_frameworks = 'TradPlusFrameworks/**/*.framework'


s.vendored_libraries = ['TradPlusFrameworks/GDTMob/GDTSDK/*.a','TradPlusFrameworks/Kidoz/KidozSDK/*.a','TradPlusFrameworks/YouDao/YDSDK/*.a',]


s.resources = ['TradPlusFrameworks/**/*.bundle',"Assets/**/*"]


s.dependency 'TradPlusAdSDK', '13.1.0'
s.dependency 'TradPlusAdSDK/FacebookAdapter', '13.1.0'
# s.dependency 'FBAudienceNetwork','6.16.0'
s.dependency 'TradPlusAdSDK/AdMobAdapter', '13.1.0'
s.dependency 'Google-Mobile-Ads-SDK','11.13.0'
s.dependency 'TradPlusAdSDK/UnityAdapter', '13.1.0'
s.dependency 'UnityAds','4.13.0'
s.dependency 'TradPlusAdSDK/AppLovinAdapter', '13.1.0'
s.dependency 'AppLovinSDK','13.0.1'
s.dependency 'TradPlusAdSDK/VungleAdapter', '13.1.0'
s.dependency 'VungleAds', '7.4.4'
s.dependency 'TradPlusAdSDK/InMobiAdapter', '13.1.0'
s.dependency 'InMobiSDK' ,'10.8.0'
s.dependency 'TradPlusAdSDK/MintegralAdapter', '13.1.0'
s.dependency 'MintegralAdSDK' ,'7.7.5'
s.dependency 'MintegralAdSDK/All','7.7.5'
s.dependency 'TradPlusAdSDK/SmaatoAdapter', '13.1.0'
s.dependency 'smaato-ios-sdk', '22.9.2'
s.dependency 'TradPlusAdSDK/TPCrossAdapter', '13.1.0'
s.dependency 'TradPlusAdSDK/BigoAdapter', '13.1.0'
s.dependency 'BigoADS','4.6.0'


s.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 arm64' }
end