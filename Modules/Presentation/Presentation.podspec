
Pod::Spec.new do |s|
  s.name             = "Presentation"
  s.version          = "1.0.0"
  s.summary          = "Presentation Module"
  s.description      = <<-DESC
Presentation Module
                       DESC

  s.homepage         = "https://github.com/devyhan"
  s.author           = { "devyhan" => "devyhan93@gmail.com" }
  s.source           = { :git => "https://github.com/devyhan/WeatherList", :tag => "v#{s.version}" }

  s.ios.deployment_target = '10.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }

  s.source_files = 'Presentation/**/*.{m,h,swift}'
  s.resources = "Presentation/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

  # 3rd Party
  s.dependency 'SnapKit'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'

  # Modules
  s.dependency 'Domain'
  s.dependency 'Utils'
  s.dependency 'Container'

end
