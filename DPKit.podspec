Pod::Spec.new do |s|
  s.name         = "DPKit"
  s.version      = "0.0.13"
  s.summary      = "Utilities for Mac OS X."
  s.homepage     = "http://dpostigo.com"
  s.license      = 'BSD'
  s.author       = { "Dani Postigo" => "dani@firstperson.is" }
  s.source       = { :git => "https://github.com/dpostigo/DPKit.git", :tag => s.version.to_s }
  s.requires_arc = true


  s.ios.deployment_target = '4.3'
  s.osx.deployment_target = '10.8'





  s.subspec 'Graphics' do |graphics|
    graphics.osx.deployment_target = '10.7'
    graphics.osx.source_files = 'DPKit/osx/Graphics/**/*.{h,m}'
    # graphics.ios.source_files = 'DPKit/ios/Graphics/**/*.{h,m}'
  end

  s.subspec 'Shared' do |shared|
    shared.osx.source_files = 'DPKit/shared/**/*.{h,m}'
    shared.osx.dependency  'JMSimpleDate'
    shared.osx.dependency  'NSView-DPAutolayout'

    shared.ios.source_files = 'DPKit/shared/**/*.{h,m}'
    shared.ios.dependency  'JMSimpleDate'
  end

  s.subspec 'Mac OS X' do |mac|
    mac.dependency  'DPKit/Shared'
    mac.dependency  'DPKit/Graphics'
    mac.platform = :osx, '10.7'
    mac.source_files = 'DPKit/osx/*.{h,m}'


    mac.subspec 'Custom Views' do |views|
      views.platform = :osx, '10.7'
      views.source_files = 'DPKit/osx/Custom Views/*.{h,m}'
    end

    mac.subspec 'NSTextFieldCell' do |textFieldCell|
      textFieldCell.platform = :osx, '10.7'
      textFieldCell.source_files = 'DPKit/osx/NSTextFieldCell/*.{h,m}'
    end

  end



  s.subspec 'iOS' do |iphone|
    iphone.dependency  'DPKit/Shared'
    iphone.platform = :ios, '4.3'
    iphone.source_files = 'DPKit/ios/*.{h,m}'
  end


  s.osx.frameworks   = 'QuartzCore', 'AppKit'
  s.ios.frameworks   = 'AppKit', 'UIKit'







end
