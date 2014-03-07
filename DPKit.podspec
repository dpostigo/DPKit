Pod::Spec.new do |s|
  s.name         = "DPKit"
  s.version      = "0.0.24"
  s.summary      = "Utilities for OS X."
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
    shared.osx.source_files = 'DPKit/shared/*.{h,m}'
    shared.osx.dependency  'JMSimpleDate'
    shared.osx.dependency  'NSView-DPAutolayout'
    shared.osx.dependency  'NSView-NewConstraints'

    shared.ios.source_files = 'DPKit/shared/*.{h,m}'
    shared.ios.dependency  'JMSimpleDate'

    shared.subspec 'Formatters' do |formatters|
        formatters.source_files = 'DPKit/shared/Formatters/**/*.{h,m}'
    end


  end

  s.subspec 'OS X' do |mac|
    mac.dependency  'DPKit/Shared'
    mac.dependency  'DPKit/Graphics'
    mac.dependency  'DPKit/OS X/Utils'

    mac.dependency  'NSView-DPFrameUtils'
    mac.dependency  'NSColor-BlendingUtils'
    mac.dependency  'CALayer-DPUtils'

    mac.osx.dependency  'DPKit-NSButton'
    mac.osx.dependency  'DPKit-NSCell'
    mac.osx.dependency  'DPKit-NSComboBox'
    mac.osx.dependency  'DPKit-NSControl'
    mac.osx.dependency  'DPKit-NSTextField'
    # mac.dependency  'DPKit-NSTokenField'
    mac.osx.dependency  'DPKit-NSView'
    mac.osx.dependency  'DPKit-NSViewController'
    mac.osx.dependency  'DPKit-NSWindow'
    mac.osx.dependency  'DPKit-Styles'
    mac.osx.dependency  'DPKit-TimeInput'

    mac.platform = :osx, '10.7'

    mac.source_files = 'DPKit/osx/*.{h,m}'



    mac.subspec 'Utils' do |utils|
      utils.platform = :osx, '10.7'
      utils.source_files = 'DPKit/osx/Utils/**/*.{h,m}'
    end


    mac.subspec 'Value Transformers' do |transformers|
      transformers.platform = :osx, '10.7'
      transformers.source_files = 'DPKit/osx/Value Transformers/**/*.{h,m}'
    end

  
  end



  s.subspec 'iOS' do |iphone|
    iphone.dependency  'DPKit/Shared'
    iphone.platform = :ios, '4.3'
    iphone.source_files = 'DPKit/ios/*.{h,m}'
  end


  s.osx.frameworks   = 'QuartzCore', 'AppKit'
  s.ios.frameworks   = 'AppKit', 'UIKit'

  
  s.osx.dependency 'NSView-DPFrameUtils'







end
