import 'package:flutter/services.dart';
import 'dart:io';

class SmsSender {

  //singleton
  static final SmsSender _singleton = new SmsSender._internal();

  factory SmsSender(){
    return _singleton;
  }

  SmsSender._internal();

  /*
    This checks if the current device is Android OS. Then calls SMSManager from Android native.
    It just prints a message if device is not Android
  */
  sendSMS(String number, String body) async{

    //method call to native android that 
    if(Platform.isAndroid){
      const platform = const MethodChannel('beacon.flutter.dev/sms_sender');
      try {
        platform.invokeMethod('sendSMSAndroid', {'body': body, 'number': number});
      } on PlatformException catch (e) {
        print(e);
      }
    
    } else if(Platform.isIOS){
      print("sms sending is not supported in iOS");
    
    } else{
      print("sms sending is not supported on this device");
    }
  }
}