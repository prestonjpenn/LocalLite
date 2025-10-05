import Flutter
import UIKit
import GoogleMaps
import flutter_dotenv

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    dotenv.load(fileName: ".env")

    if let apiKey = dotenv.env["GOOGLE_MAPS_API_KEY"] {
      GMSServices.provideAPIKey(apiKey)
    } else {
      print("⚠️ Google Maps API key not found in .env")
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
