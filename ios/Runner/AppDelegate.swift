import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    //This is the configuration to port native iOS into flutter
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "beacon.flutter.dev/beacon", binaryMessenger: controller)

    channel.setMethodCallHandler {[unowned self] (methodCall, result) in

      //This is the method that calls openURL
      if methodCall.method == "openUrlIOS"{
        
        //get url
        let url = URL(string: (methodCall.arguments as! Dictionary<String, AnyObject>)["url"] as! String)!
        
        //open url based on OS
        if #available(iOS 10, *) {
          UIApplication.shared.open(url)
        } else{
          UIApplication.shared.openURL(url)
      }

    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
