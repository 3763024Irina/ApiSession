platform :ios, '11.0'

target 'ApiSession' do
  use_frameworks!

  # Networking
  pod 'Alamofire', '5.6'
  pod 'Moya', '~> 14.0'

  # JSON Serialization
  pod 'ObjectMapper', '~> 4.2'

  # Image Caching
  pod 'Kingfisher', '~> 6.3'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.7'
    end
  end
end
