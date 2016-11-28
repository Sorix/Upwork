Pod::Spec.new do |s|
  s.name             = "Upwork"
  s.version          = "0.2.0"
  s.summary          = "Upwork API"
  s.homepage         = "https://github.com/Sorix/Upwork"
  s.license          = 'MIT License'
  s.author           = { "Vasily Ulianov" => "Sorix@users.noreply.github.com" }
  s.source           = { :git => "https://github.com/Sorix/Upwork", :tag => s.version }

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target  = '10.10'
  s.requires_arc = true

  s.source_files = 'Sources/**/*'
  s.module_name = 'Upwork'

  s.dependency 'OAuthSwift', '~> 1.1.0'
  s.dependency 'SwiftyJSON', '~> 3.1.0'
end
