platform :ios, '12.0'

target 'WeatherList' do
  use_frameworks!

  pod 'SnapKit'
  pod 'RxSwift'
  pod 'RxCocoa'

  target 'Tests' do
    inherit! :search_paths
    pod 'RxTest'
    pod 'RxNimble/RxTest'
  end
end

# pod install hook
post_install do |installer|
  # Pods 프로젝트 설정 수정 
  installer.pods_project.build_configurations.each do |config|
    config.build_settings['DEAD_CODE_STRIPPING'] = 'YES'
  end

  # Pods 프로젝트의 타겟 설정 수정
 installer.pods_project.targets.each do |target|
   target.build_configurations.each do |config|
     config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
   end
 end
end
