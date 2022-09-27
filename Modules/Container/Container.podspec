
Pod::Spec.new do |s|
  s.name             = "Container"
  s.version          = "1.0.0"
  s.summary          = "Container Module"
  s.description      = <<-DESC
Domain Module
                       DESC

  s.homepage         = "https://github.com/devyhan"
  s.author           = { "devyhan" => "devyhan93@gmail.com" }
  s.source           = { :git => "https://github.com/devyhan/WeatherList", :tag => "v#{s.version}" }

  s.ios.deployment_target = '12.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }

  s.source_files = 'Container/**/*.{m,h,swift}'

  s.dependency 'Domain'
  s.dependency 'Data'

end