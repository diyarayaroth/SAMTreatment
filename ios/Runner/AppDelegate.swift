import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      // TODO: Replace with your Google Maps API key from Keys.plist or environment
      GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
