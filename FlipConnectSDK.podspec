#
#  Be sure to run `pod spec lint FlipConnectSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "FlipConnectSDK"
  s.version      = "0.2.0"
  s.summary      = "Login SDK to use Flip Connect"
  s.description  = <<-DESC
It connects to Flip Connect API using OAuth
                   DESC
  s.homepage     = "http://flipconnect.io"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author    = "Munir Wanis"
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/Flip-Payments/connect-sdk-ios.git", :tag => "#{s.version}" }
  s.source_files  = "FlipConnectSDK", "FlipConnectSDK/**/*.{h,swift}"
end
