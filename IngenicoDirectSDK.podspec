Pod::Spec.new do |s|

  s.name          = "IngenicoDirectSDK"
  s.version       = "1.0.0"
  s.summary       = "Ingenico Direct Objective-c SDK"
  s.description   = <<-DESC
                    This native iOS SDK facilitates handling payments in your apps
                    using the Ingenico ePayments platform of Ingenico ePayments.
                    DESC

  s.homepage      = "https://github.com/Ingenico/direct-sdk-client-objc"
  s.license       = { :type => "MIT", :file => "LICENSE.txt" }
  s.author        = "Ingenico"
  s.platform      = :ios, "9.0"
  s.source        = { :git => "https://github.com/Ingenico/direct-sdk-client-objc.git", :tag => s.version }
  s.source_files  = "IngenicoDirectSDK/*"
  s.resource      = "IngenicoDirectSDK/IngenicoDirectSDK.bundle"

end
