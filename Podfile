platform :ios, '12.0'

target 'WeatherList' do
  use_frameworks!

  # Modules
  pod 'Container', :path => 'Modules/Container'
  pod 'Data', :path => 'Modules/Data'
  pod 'Domain', :path => 'Modules/Domain'
  pod 'Infrastructure', :path => 'Modules/Infrastructure'
  pod 'Presentation', :path => 'Modules/Presentation'
  pod 'Utils', :path => 'Modules/Utils'

  # 3rd Party
  pod 'SnapKit'
  pod 'RxCocoa'
  pod 'RxSwift'
  pod 'RxDataSources', '~> 5.0'
  pod 'RxAppState'

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
