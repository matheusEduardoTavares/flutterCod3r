import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    //Com o as! forçamos um cast pois garantimos que o window.rootViewController
    //será um FlutterViewController
    let controller: FlutterViewController = window?.rootViewController as! 
      FlutterViewController

    let nativoChannel = FlutterMethodChannel(name: "cod3r.com.br/nativo", 
      binaryMessenger: controller.binaryMessenger)

    //Quando um método for chamado (será chamado do lado do flutter, um 
    //canal de um método, de uma funcionalidade, e quando usarmos um 
    //invokeMethod será chamado esse handler de execução de método)
    nativoChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in 

      guard call.method == "calcSum" else {
        result(FlutterMethodNotImplemented)
        return
      }

      //É chego como um array de Strings os parâmetros, então o converteremos, 
      //em que o ? garante que pode não conseguir converter e aí no caso cairá
      //no else
      if let args = call.arguments as? [String: Any],
        let a = args["a"] as? Int,
        //só entrará no novo bloco de código se conseguir converter a e b para inteiro
        let b = args["b"] as? Int {
          result(a + b)
        }
        else {
          result(-1)
        }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
