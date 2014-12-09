#
# Be sure to run `pod lib lint S4PageControl.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "S4PageControl"
  s.version          = "0.0.1"
  s.summary          = "This is an extended UIPageControl, which gives possibility to change size, color and shape of page indicators."
  s.homepage         = "https://github.com/dimka-abramov/S4PageControl"
  s.license          = 'MIT'
  s.author           = { "Dmitry Abramov" => "dmitry.i.abramov@gmail.com" }
  s.source           = { :git => "https://github.com/dimka-abramov/S4PageControl.git", :tag => 'v0.0.1' }
  s.platform     = :ios, '6.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'S4PageControl' => ['Pod/Assets/*.png']
  }
end
