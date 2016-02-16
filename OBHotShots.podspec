Pod::Spec.new do |spec|
  spec.name         = 'OBHotShots'
  spec.version      = '1.0.0'
  spec.summary      = "Some helper class for creating app screenshots using normal unit tests that can be used for the AppStore"
  spec.homepage     = "https://github.com/openbakery/HotShots"
  spec.author       = { "René Pirringer" => "rene@openbakery.org" }
  spec.social_media_url = 'https://twitter.com/rpirringer'
  spec.source       = { :git => "https://github.com/openbakery/Hotshots.git", :tag => spec.version.to_s }
  spec.platform = :ios
  spec.ios.deployment_target = '6.0'
  spec.license      = 'BSD'
  spec.requires_arc = true
	
	spec.default_subspecs = 'Default'
	spec.framework    = 'XCTest'

	spec.subspec 'Default' do |ss|
		ss.source_files = 'Core/Source/*.{h,m}', 'Core/Source/Helpers/*.{h,m}'
		ss.dependency 'OBHotShots/Script'
  end

	spec.subspec 'Script' do |ss|
		ss.source_files = 'Core/Script/*.{gradle,template}'
	end
end
