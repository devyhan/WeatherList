
Pod::Spec.new do |s|
  s.name             = "Domain"
  s.version          = "1.0.0"
  s.summary          = "Domain Module"
  s.description      = <<-DESC
Domain Module
                       DESC

  s.homepage         = "https://github.com/devyhan"
  s.author           = { "devyhan" => "devyhan93@gmail.com" }
  s.source           = { :git => "https://github.com/devyhan/WeatherList", :tag => "v#{s.version}" }

  s.ios.deployment_target = '12.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }

  s.source_files = 'Domain/**/*.{m,h,swift}'

  s.dependency 'RxSwift'

end
