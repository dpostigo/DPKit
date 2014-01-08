Pod::Spec.new do |s|
  s.name         = "DPKit"
  s.version      = "0.0.3"
  s.summary      = "Utilities for Mac OS X."
  s.homepage     = "http://dpostigo.com"
  s.license      = 'BSD'
  s.author       = { "Dani Postigo" => "dani@firstperson.is" }
  s.source       = { :git => "https://github.com/dpostigo/DPKit.git", :tag => s.version.to_s }
  s.platform     = :osx
  s.source_files = 'DPKit/*.{h,m}'
  s.frameworks   = 'QuartzCore', 'AppKit'
  s.requires_arc = true

end
