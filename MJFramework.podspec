
Pod::Spec.new do |s|

  s.name         = 'MJFramework'
  s.version      = '1.1.1'
  s.license      = 'MIT'
  s.summary      = 'some tools for iOS programming'
  s.homepage     = 'https://github.com/GuoMingJian/MJFramework'
  s.author       = { 'guomingjian' => 'GuoMJ158@163.com' }
  s.source       = { :git => 'https://github.com/GuoMingJian/MJFramework.git', :tag => s.version }
  s.requires_arc = true
  s.ios.deployment_target = "9.0"
  s.source_files = 'MJFramework/MJFramework.h'

  s.subspec 'Category' do |ss|
    ss.source_files = 'MJFramework/Category/*.{h,m}'
  end

  s.subspec 'Common' do |ss|
    ss.source_files = 'MJFramework/Common/*.{h,m}'
  end

  s.subspec 'GTMBase64' do |ss|
    ss.source_files = 'MJFramework/Encryption/GTMBase64/*.{h,m}'
  end

  s.subspec 'RSA' do |ss|
    ss.source_files = 'MJFramework/Encryption/RSA/*.{h,m}'
  end

  s.subspec 'MJMBProgressHUD' do |ss|
    ss.source_files = 'MJFramework/MJMBProgressHUD/*.{h,m}'
  end

  s.subspec 'Reachability' do |ss|
    ss.source_files = 'MJFramework/Reachability/*.{h,m}'
  end

  s.subspec 'UIKit' do |ss|
    ss.source_files = 'MJFramework/UIKit/*.{h,m}'
  end

end
