#
# Be sure to run `pod lib lint BasicKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BasicKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of BasicKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ourfor/BasicKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ourfor' => 'ourfor@qq.com' }
  s.source           = { :git => 'https://github.com/ourfor/BasicKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'BasicKit/Classes/*'
  
  s.vendored_frameworks = 'BasicKit.framework'

  s.subspec 'Util' do |ss|
    ss.source_files = 'BasicKit/Classes/Util/**/*'
  end

  s.subspec 'View' do |ss|
    ss.source_files = 'BasicKit/Classes/View/**/*'
  end

  s.subspec 'Resource' do |ss|
    ss.resource_bundles = {
      'Asset' => ['BasicKit/Assets/**/*'],
    }
  end

  s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
