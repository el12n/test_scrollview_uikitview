import UIKit
import Flutter

class UIRectViewFactory: NSObject, FlutterPlatformViewFactory {
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return UIRectView(frame)
    }
}

class UIRectView: NSObject, FlutterPlatformView {
    let frame: CGRect

    init(_ frame: CGRect) {
        self.frame = frame
    }

    func view() -> UIView {
        let view: UIView = UIView(frame: frame)
        view.backgroundColor = UIColor.red
        return view
    }
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    registrar(forPlugin: "flutter")?.register(UIRectViewFactory(), withId: "rect")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
