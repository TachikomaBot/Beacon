import 'dart:io';
import 'package:device_info/device_info.dart';

/*
  This returns true if IOS is 8-10. Will as substitute for flutter_web_auth's compatibility limitations
*/
Future<bool> detectLowIOS() async{
  if(Platform.isIOS){
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var version = int.parse(iosInfo.systemVersion.split('.')[0]);
      if(version < 11) return true;
  }
  return false;
}