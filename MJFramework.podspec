
Pod::Spec.new do |s|


  s.name         = "MJFramework"
  s.version      = "1.1.8"
  s.summary      = "some tools for iOS programming "
  s.homepage     = "https://github.com/GuoMingJian/MJFramework"
  s.license      = "MIT"
  s.author       = { "guomingjian" => "GuoMJ158@163.com" }
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/GuoMingJian/MJFramework.git", :tag => "v#{s.version}" }
  s.source_files = "MJFramework", "MJFramework/*.{h,m}", "MJFramework/**/*.{h,m}", "MJFramework/**/**/*.{h,m}"
  #s.vendored_frameworks = 'src/MJFramework.framework'
  s.requires_arc = true

end

