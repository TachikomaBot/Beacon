import 'package:Beacon/controllers/auth/google_auth.dart';
import 'package:Beacon/controllers/helpers/auth.dart';
import 'package:Beacon/controllers/helpers/error.dart';

/*
  This calls the GoogleAuth class and uses its methods to actually sign in the user
*/
Future<bool> googleSignInAuth() async {
  final auth = GoogleAuth();

  //Declare variables that can change value
  String token = "";

  final googleClientId = getGoogleClientId();
  final googleWebsite = 'accounts.google.com';
  final googleAuthExtension = '/o/oauth2/v2/auth';
  final googleScopes = 'https://www.googleapis.com/auth/drive.file https://www.googleapis.com/auth/gmail.send https://www.googleapis.com/auth/userinfo.email';
  final tokenAddress = 'https://oauth2.googleapis.com/token';

  final callbackUrlScheme = getGoogleCallBack();
  auth.setUrl(googleWebsite, googleAuthExtension, googleClientId, callbackUrlScheme, scopes: googleScopes, tokenAddress: tokenAddress);

  try{          
    token = await auth.getToken();

  } on FileDNEError{
    print(new FileDNEError());
    await auth.performAuth();
    token = await auth.getToken();

  } on WrongAuthTypeError{ 
    print(new WrongAuthTypeError());
    await auth.performAuth();
    token = await auth.getToken();

  }

  print(token);

  if (token != null) {
    return true;
  }
  else {
    return false;
  }
}
