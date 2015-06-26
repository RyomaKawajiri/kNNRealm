#
# Be sure to run `pod lib lint kNNRealm.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "kNNRealm"
  s.version          = "0.1.0"
  s.summary          = "Simple k-nearest neighbors methods library using RealmSwift."
  s.description      = <<-DESC
                       Simple k-nearest neighbors methods library using RealmSwift.

                       Features

                         - Fast approximate search by using powerful realm queries
                         - More Fast with locality sensitive hashing (LSH)
                         - Works on both iOS & OS X
                       DESC
  s.homepage         = "https://github.com/rkawajiri/kNNRealm"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Kawajiri Ryoma" => "ryoma.edison@gmail.com" }
  s.source           = { :git => "https://github.com/rkawajiri/kNNRealm.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'kNNRealm' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'RealmSwift', '~> 0.92.3'
end
