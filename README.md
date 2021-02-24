Ingenico Direct Objective-C SDK
=========================

The Ingenico Direct Objective-C SDK provides a convenient way to support a large number of payment methods inside your iOS app.
It supports iOS 9.0 and up out-of-the-box.
The Objective-C SDK comes with an [example app](https://github.com/Ingenico/direct-sdk-client-ios-example) that illustrates the use of the SDK and the services provided by Ingenico ePayments on the Ingenico ePayments platform.

See the [Ingenico Direct Developer Hub](https:///support.direct.ingenico.com/documentation/sdk/mobile/ios/) for more information on how to use the SDK.


Use the SDK with Carthage or CocoaPods
---------------------------------------
The Ingenico Direct Objective-C SDK is available via two package managers: [CocoaPods](https://cocoapods.org/) or [Carthage](https://github.com/Carthage/Carthage).

### CocoaPods

You can add the Swift SDK as a pod to your project by adding the following to your `Podfile`:

```
$ pod 'IngenicoDirectSDK'
```

Afterwards, run the following command:

```
$ pod install
```

### Carthage

You can add the Swift SDK with Carthage, by adding the following to your `Cartfile`:

```
$ github "Ingenico/direct-sdk-client-ios"
```

Afterwards, run the following command:

```
$ carthage update
```

Run the SDK locally
------------

To obtain the Objective-C SDK, first clone the code from GitHub:

```
$ git clone https://github.com/Ingenico/direct-sdk-client-ios.git
```

Open the Xcode project that is included to test the SDK.


Migrating from Connect to Direct
------------

In case the Connect SDK was used before, and the Direct SDK needs to be used instead
in the project, search for Connect in your code and replace it with Direct.
Also change each prefix with IC with ID, like ICSession will become IDSession
