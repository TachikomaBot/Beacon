import 'package:Beacon/controllers/callers/auth.dart';
import 'package:Beacon/controllers/callers/contact.dart';
import 'package:Beacon/controllers/uploaders/gdrive_uploader.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
  This will be called in the LoginScreen
*/
Future <bool> onActiveSignIn() async{

  //determine what auth is being used
  bool result = await googleSignInAuth();
  final uploader = GDriveUploader();

  if (result) {
    print('sign in succeeded');

    await setupContactManager();

    //create a Beacon folder where all recording will be saved to
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uploader.setFolderID(prefs.getString('folderID'));
    if(uploader.folderID == null) uploader.handleUploadFolder('Beacon'); 
    
    return true;
  }

  print('sign in failed');
  return false;
}