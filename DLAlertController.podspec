Pod::Spec.new do |s|
  s.name             = "DLAlertController"
  s.version          = "0.2.0"
  s.summary          = "Custom alert controller for iOS platform."
  s.homepage         = "https://github.com/sdkdimon/DLAlertController"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Dmitry Lizin" => "sdkdimon@gmail.com" }
  s.source           = { :git => "https://github.com/sdkdimon/DLAlertController.git", :tag => s.version }

  s.platform     = :ios, '9.0'
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  s.module_name = 'DLAlertController'
  s.source_files = 'DLAlertController/DLAlertController/*.{h,m}', 'DLAlertController/DLAlertController/Actions/*.{h,m}', 'DLAlertController/DLAlertController/Presentation/*.{h,m}'
  s.module_map = 'DLAlertController/DLAlertController/SupportingFiles/module.modulemap'

end



