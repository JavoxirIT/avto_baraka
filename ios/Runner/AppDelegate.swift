import UIKit
import Flutter
import flutter_local_notifications
//import app_settings

import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
     
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    GeneratedPluginRegistrant.register(with: self)
//    AppSettingsPlugin.register(with: self.registrar(forPlugin: "AppSettingsPlugin")!)
    // Инициализация flutter_local_notifications
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }

    // Инициализация MethodChannel для вызовов
    let controller = window?.rootViewController as! FlutterViewController
    let callChannel = FlutterMethodChannel(name: "com.autobaraka.auto_baraka/call_phone",
                                            binaryMessenger: controller.binaryMessenger)
    callChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "callPhone" {
        if let args = call.arguments as? [String: Any],
           let number = args["number"] as? String {
          self.callPhone(number: number, result: result)
        } else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "Phone number not provided", details: nil))
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    super.application(application, didFinishLaunchingWithOptions: launchOptions)
    return true
  }

  // Метод для совершения телефонного звонка
  private func callPhone(number: String, result: @escaping FlutterResult) {
    if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
      result(nil)
    } else {
      result(FlutterError(code: "UNAVAILABLE", message: "Cannot call phone number", details: nil))
    }
  }

  // Обработка уведомлений
  override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .badge, .sound])
  }
    
}