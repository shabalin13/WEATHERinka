# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
  end
 end
end

target 'WEATHERinka' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WEATHERinka
  pod 'Alamofire'
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
  pod 'Charts'
  pod 'SwiftJWT'
  
  target 'WEATHERinkaTests' do
    # Pods for testing
    inherit! :search_paths
    pod 'RxBlocking', '6.5.0'
    pod 'RxTest', '6.5.0'
  end

  target 'WEATHERinkaUITests' do
    # Pods for testing
  end

end
