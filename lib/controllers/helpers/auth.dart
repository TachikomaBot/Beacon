
import 'dart:io';
import 'package:Beacon/controllers/auth/google_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/*
  This is the method that calls native iOS code to open auth session for iOS < 11
*/
openURLSwiftNative() async{
  final auth = GoogleAuth(); //only set for google auth right now

  const platform = const MethodChannel("beacon.flutter.dev/beacon");
    try{
      platform.invokeMethod("openUrlIOS", {"url": auth.url});
    } on PlatformException catch(error){
      print(error);
    }
}

/* 
  This determines the correct google client id depending on the device's os
*/
String getGoogleClientId(){
  var ios = '${DotEnv().env['GOOGLE_CLIENT_ID_IOS']}';
  var android = '${DotEnv().env['GOOGLE_CLIENT_ID_ANDROID']}';

  if(Platform.isIOS){ 
    return ios;
  
  } else if(Platform.isAndroid){
    return android;
  
  } else {
    //throw an error?
    return null;
  }
}

/* 
  This determines the correct google callback url scheme depending on the device's os
*/
String getGoogleCallBack(){
  var ios = '${DotEnv().env['GOOGLE_CALLBACK_IOS']}';
  var android = '${DotEnv().env['GOOGLE_CALLBACK_ANDROID']}';

  if(Platform.isIOS){ 
    return ios;
  
  } else if(Platform.isAndroid){
    return android;
  
  } else {
    //throw an error?
    return null;
  }
}

/*
  This will generate/return the Header map needed for sending via gmail.
  This can be potentially moved up to EmailSender if other email services
  have the same header structure
*/
Future<Map> generateHeader() async{
  var token = await GoogleAuth().getToken();
  var header = { 'Authorization': 'Bearer '+ token };

  return header;
}
