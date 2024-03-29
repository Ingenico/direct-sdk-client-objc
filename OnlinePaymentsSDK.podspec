Pod::Spec.new do |s|

  s.name          = "OnlinePaymentsSDK"
  s.version       = "2.1.1"
  s.summary       = "Online Payments Objective-c SDK"
  s.description   = <<-DESC
                    This native iOS SDK facilitates handling payments in your apps
                    using the Online Payments platform.
                    DESC

  s.homepage      = "https://github.com/wl-online-payments-direct/sdk-client-objc"
  s.license       = { :type => "MIT", :file => "LICENSE.txt" }
  s.author        = "Worldline"
  s.platform      = :ios, "9.0"
  s.source        = { :git => "https://github.com/wl-online-payments-direct/sdk-client-objc.git", :tag => s.version }
  s.source_files  = "OnlinePaymentsSDK/*"
  s.exclude_files = "OnlinePaymentsSDK/Info.plist"
  s.resource      = "OnlinePaymentsSDK/OnlinePaymentsSDK.bundle"
end
