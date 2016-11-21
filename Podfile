# Uncomment this line if you're using Swift
use_frameworks!

def my_pods
	pod 'OAuthSwift'
	pod 'SwiftyJSON'
end

target 'Upwork-iOS' do
	platform :ios, '9.0'
	my_pods
end

target 'Upwork-OSX' do
	platform :osx, '10.10'
	my_pods
end

# Enable Swift 3
post_install do |installer|
	installer.pods_project.build_configurations.each do |config|
		config.build_settings['SWIFT_VERSION'] = '3.0'
	end
end
