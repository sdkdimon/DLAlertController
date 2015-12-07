Pod::Spec.new do |s|
  s.name             = "DLAlertController"
  s.version          = "0.0.2"
  s.summary          = "Custom alert controller for iOS platform."
  s.homepage         = "https://github.com/sdkdimon/DLAlertController"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Dmitry Lizin" => "sdkdimon@gmail.com" }
  s.source           = { :git => "https://github.com/sdkdimon/DLAlertController.git", :tag => s.version }

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true
  s.module_name = 'DLAlertController'
  s.source_files = 'DLAlertController/DLAlertController/*.{h,m}'
  
  s.subspec 'Presentation' do |ss|
      ss.source_files = 'DLAlertController/DLAlertController/Presentation/*.{h,m}'
  end
 
  s.subspec 'Actions' do |ss|
      ss.source_files = 'DLAlertController/DLAlertController/Actions/*.{h,m}'
  end    

end



