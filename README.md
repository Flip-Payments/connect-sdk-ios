# FlipConnectSDK

## Installation

### Carthage

### Cocoapods

## Usability

### Configuration

On your project, click on 'Info' tab and select Url Types. On `identifier` field it's mandatory that the name is **FlipConnectSDK** and on URL Schemes you must put the scheme that was set for your Merchant URI, for example:

If the registered Merchant URI is `flipConnect://application` your Url Schemes must be **flipConnect**, in other words everything **before** `://` is your Url Scheme.

![Url Schema Creation](img/urlTypes.png)

On your `Info.plist` you must add your **ClientID**, **ClientSecret** and **RedirectURI** registered on our API, it'll be used by the SDK to handle redirect from our login page:

```xml
<key>FlipConnectSDK</key>
<dict>
  <key>RedirectURI</key>
  <string>flipConnect://application</string>
  <key>ClientSecret</key>
  <string>FD5A0D34-878D-483B-9CC0-573DFB82A75B</string>
  <key>ClientID</key>
  <string>D7F667C8-199F-6B10-B53A-0BCDDEFADB31</string>
</dict>
```
The final result will be something like this:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>en</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>$(PRODUCT_NAME)</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0</string>
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLName</key>
			<string>FlipConnectSDK</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>flipConnect</string>
			</array>
		</dict>
	</array>
	<key>CFBundleVersion</key>
	<string>1</string>
	<key>FlipConnectSDK</key>
	<dict>
		<key>RedirectURI</key>
		<string>flipConnect://application</string>
		<key>ClientSecret</key>
		<string>FD5A0D34-878D-483B-9CC0-573DFB82A75B</string>
		<key>ClientID</key>
		<string>D7F667C8-199F-6B10-B53A-0BCDDEFADB31</string>
	</dict>
	<key>LSRequiresIPhoneOS</key>
	<true/>
	<key>UILaunchStoryboardName</key>
	<string>LaunchScreen</string>
	<key>UIMainStoryboardFile</key>
	<string>Main</string>
	<key>UIRequiredDeviceCapabilities</key>
	<array>
		<string>armv7</string>
	</array>
	<key>UISupportedInterfaceOrientations</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>UISupportedInterfaceOrientations~ipad</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitraryLoads</key>
		<true/>
	</dict>
</dict>
</plist>

```
### ViewController

### AppDelegate

## Contributing

## Issues
