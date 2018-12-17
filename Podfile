# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'pixelwallet-ios' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for pixelwallet-ios

pod 'RxSwift', '~> 4.0'
pod 'RxCocoa', '~> 4.0'
pod 'ViewModelBindable'
pod 'Swinject'
pod 'KeychainAccess'
pod 'RxDataSources'
pod 'RxRealm'

end

post_install do |installer|
    # Downgrade Swift language version to 4.0 for Pods that don't support Swift 4.2
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
