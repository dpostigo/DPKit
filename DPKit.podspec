Pod::Spec.new do |s|
  s.name         = "DPKit"
  s.version      = "0.0.7"
  s.summary      = "Utilities for Mac OS X."
  s.homepage     = "http://dpostigo.com"
  s.license      = 'BSD'
  s.author       = { "Dani Postigo" => "dani@firstperson.is" }
  s.source       = { :git => "https://github.com/dpostigo/DPKit.git", :tag => s.version.to_s }
  # s.platform     = :osx, '10.7'
  s.requires_arc = true


  s.ios.deployment_target = '4.3'
  s.osx.deployment_target = '10.8'



  s.subspec 'Shared' do |shared|
    shared.osx.source_files = 'DPKit/shared/**/*.{h,m}'
    shared.ios.source_files = 'DPKit/shared/**/*.{h,m}'
  end

  s.subspec 'Mac OS X' do |mac|
    mac.dependency  'DPKit/Shared'
    mac.platform = :osx, '10.7'
    mac.source_files = 'DPKit/osx/*.{h,m}'

    mac.subspec 'Graphics' do |graphics|
      graphics.platform = :osx, '10.7'
      graphics.source_files = 'DPKit/osx/Graphics/*.{h,m}'
    end

    mac.subspec 'Custom Views' do |customViews|
      customViews.platform = :osx, '10.7'
      customViews.source_files = 'DPKit/osx/Custom Views/*.{h,m}'
    end
  end



  s.subspec 'iOS' do |iphone|
    iphone.dependency  'DPKit/Shared'
    iphone.platform = :ios, '4.3'
    iphone.source_files = 'DPKit/ios/*.{h,m}'
  end


  s.osx.frameworks   = 'QuartzCore', 'AppKit'

  s.osx.dependency   'JMSimpleDate'
  s.osx.dependency   'NSView-DPAutolayout', '~> 0.0.11'
  
  s.ios.dependency   'JMSimpleDate'
  s.ios.frameworks   = 'AppKit', 'UIKit'







end
