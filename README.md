ShareExtensionTutorial
======================

A basic Share Extension for iOS8 in Objective-C
------------------

A Basic Share Extension for iOS8 in Objective-C

This Share Extension can:

* Show up in the Safari Share Sheet
* get a list of options from the main app
* display those options in an extension and allow the user to select from them
* save the text the user enters in the extension and save it, along with the option
* recall that text/option in the main app when it loads again
* do things with URLs and Images that have been shared

You will need to:
-----------------

1. Set up app groups: Click on your project in xcode and then click on your project in the target list then go to Capabilities>App Groups. Turn it on and set it up with the name of your choice. Then do the same for your extension, adding it to the app group you just made.
2. Set up your NSExtensionRules

If all you want is Safari, change your extensions info.plist, in the NSExtension section to:

`
<dict>
<key>NSExtensionAttributes</key>
<dict>
<key>NSExtensionActivationRule</key>
<dict>
<key>NSExtensionActivationSupportsImageWithMaxCount
ImageWithMaxCount</key>
<integer>1</integer>
<key>NSExtensionActivationSupportsWebURLWithMaxCount</key>
<integer>1</integer>
</dict>
</dict>
<key>NSExtensionMainStoryboard</key>
<string>MainInterface</string>
<key>NSExtensionPointIdentifier</key>
<string>com.apple.share-services</string>
</dict>
`
