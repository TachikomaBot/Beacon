import 'package:permission_handler/permission_handler.dart';

/* 
  This request permissions in bulk. To be called in ControlCenterScreen.
*/
requestPermissions() async{
  var permissions = [
    PermissionGroup.camera,
    PermissionGroup.microphone,
    PermissionGroup.storage,
    PermissionGroup.photos,
    PermissionGroup.sms,
    PermissionGroup.locationAlways,
    PermissionGroup.locationWhenInUse,
    PermissionGroup.notification
  ];

  await PermissionHandler().requestPermissions(permissions);
}
