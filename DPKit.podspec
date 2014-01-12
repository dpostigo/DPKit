Pod::Spec.new do |s|
  s.name         = "DPKit"
  s.version      = "0.0.3"
  s.summary      = "Utilities for Mac OS X."
  s.homepage     = "http://dpostigo.com"
  s.license      = 'BSD'
  s.author       = { "Dani Postigo" => "dani@firstperson.is" }
  s.source       = { :git => "https://github.com/dpostigo/DPKit.git", :tag => s.version.to_s }
  s.platform     = :osx, '10.7'
  s.frameworks   = 'QuartzCore', 'AppKit'
  s.requires_arc = true



  s.ios.deployment_target = '4.3'
  s.osx.deployment_target = '10.7'

  # s.source_files = 'DPKit/*.{h,m}'
  # s.osx.source_files = 'DPKit/*.{h,m}', 'CALayer-DPUtils-OSX/*.{h,m}'


  s.subspec 'Shared' do |shared|
    shared.osx.source_files = 'DPKit/shared/*.{h,m}'
    shared.ios.source_files = 'DPKit/shared/*.{h,m}'

  end

  s.subspec 'Mac OS X' do |mac|
    mac.osx.source_files = 'DPKit/osx/**/*.{h,m}'
  end

  s.osx.dependency   'NSView-DPAutolayout'


  s.subspec 'iOS' do |iphone|
    iphone.ios.source_files = 'DPKit/ios/**/*.{h,m}'
  end
  # s.ios.source_files = 'CALayer-DPUtils/*.{h,m}', 'CALayer-DPUtils-iOS/*.{h,m}'

  # s.frameworks = 'QuartzCore'
  # s.ios.frameworks = 'UIKit'
  # s.osx.dependency 'DPKit'







end
