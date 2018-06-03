
Pod::Spec.new do |s|


  s.name         = "MJFramework"
  s.version      = "1.0.1"
  s.summary      = "some tools for iOS programming "
  s.homepage     = "https://github.com/GuoMingJian/MJFramework"
  s.license      = "MIT (example)"
  s.author             = { "guomingjian" => "GuoMJ158@163.com" }
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "http://EXAMPLE/MJFramework.git", :tag => "#{s.version}" }
  s.vendored_frameworks = 'src/MJFramework.framework'
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"


end
