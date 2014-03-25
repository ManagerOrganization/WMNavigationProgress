Pod::Spec.new do |s|
  s.name         = "WMNavigationProgress"
  s.version      = "0.1.0"
  s.summary      = "A progress bar at the bottom of the navigation bar as seen in the Messages.app and Safari.app"
  s.homepage     = "https://github.com/wmattelaer/WMNavigationProgress"
  s.screenshots  = "https://raw.github.com/wmattelaer/WMNavigationProgress/master/screenshot.png"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Willem Mattelaer" => "willem.mattelaer@gmail.com" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => 'https://github.com/wmattelaer/WMNavigationProgress.git' }
  s.source_files = 'WMNavigationProgress/*.{h,m}'
  s.requires_arc = true

end
