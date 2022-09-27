
Pod::Spec.new do |s|
  s.name             = "Data"
  s.version          = "1.0.0"
  s.summary          = "Data Module"
  s.description      = <<-DESC
Data Module
                       DESC
                       
  s.homepage         = "https://github.com/devyhan"
  s.author           = { "devyhan" => "devyhan93@gmail.com" }
  s.source           = { :git => "https://github.com/devyhan/WeatherList", :tag => "v#{s.version}" }

  s.ios.deployment_target = '10.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }

  s.source_files = 'Data/**/*.{m,h,swift}'

  # 3rd Party
  s.dependency 'RxSwift'

  # Modules
  s.dependency 'Domain'
  s.dependency 'Infrastructure'
  s.dependency 'Utils'

end
