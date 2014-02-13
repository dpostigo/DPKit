Pod::Spec.new do |s|
  s.name         = "DPKit"
  s.version      = "0.0.18"
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
    shared.osx.source_files = 'DPKit/shared/**/*.{h,m}'
    shared.osx.dependency  'JMSimpleDate'
    shared.osx.dependency  'NSView-DPAutolayout'
    shared.osx.dependency  'NSView-NewConstraints'

    shared.ios.source_files = 'DPKit/shared/**/*.{h,m}'
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



    mac.subspec 'Custom Views' do |views|
      views.platform = :osx, '10.7'
      views.source_files = 'DPKit/osx/Custom Views/*.{h,m}'
    end




    mac.subspec 'DPTimeInputTextField' do |timeInputTextField|
        timeInputTextField.dependency  'DPKit/Shared/Formatters'
        timeInputTextField.source_files = 'DPKit/osx/DPTimeInputTextField/**/*.{h,m}'
    end

    mac.subspec 'NSButton' do |button|
        button.dependency  'NSView-DPFrameUtils'
        button.dependency  'DPKit/OS X/Cells/NSButtonCell'
        button.source_files = 'DPKit/osx/NSButton/**/*.{h,m}'
    end

    mac.subspec 'Cells' do |cell|
        cell.subspec 'Cells-Core' do |cellCore|
          cellCore.source_files = 'DPKit/osx/Cells/*.{h,m}'
        end

        cell.subspec 'NSButtonCell' do |buttonCell|
          buttonCell.dependency 'DPKit/OS X/Utils'
          buttonCell.dependency 'DPKit/OS X/Cells/Cells-Core'
          buttonCell.platform = :osx, '10.7'
          buttonCell.source_files = 'DPKit/osx/Cells/NSButtonCell/*.{h,m}'
        end

        cell.subspec 'NSComboBoxCell' do |comboCell|
          comboCell.dependency 'DPKit/OS X/Cells/Cells-Core'
          comboCell.platform = :osx, '10.7'
          comboCell.source_files = 'DPKit/osx/Cells/NSComboBoxCell/*.{h,m}'
        end

        cell.subspec 'NSTextFieldCell' do |textFieldCell|
          textFieldCell.dependency 'DPKit/OS X/Cells/Cells-Core'
          textFieldCell.platform = :osx, '10.7'
          textFieldCell.source_files = 'DPKit/osx/Cells/NSTextFieldCell/*.{h,m}'
        end

        cell.subspec 'NSTokenFieldCell' do |tokenCell|
          tokenCell.dependency 'DPKit/OS X/Cells/Cells-Core'
          tokenCell.platform = :osx, '10.7'
          tokenCell.source_files = 'DPKit/osx/Cells/NSTokenFieldCell/*.{h,m}'
        end
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
