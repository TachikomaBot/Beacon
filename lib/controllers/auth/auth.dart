import 'dart:io';
import 'package:Beacon/controllers/helpers/auth.dart';
import 'package:Beacon/controllers/helpers/detect_os.dart';
import 'package:Beacon/controllers/helpers/error.dart';
import 'package:Beacon/controllers/helpers/store.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'dart:convert' show jsonDecode;

/* 
  This class is responsible for obtaining access tokens that are needed for OAuth
  reference: https://developers.google.com/identity/protocols/OAuth2InstalledApp?authuser=1
*/
class Auth{

  Auth({String authType = "Generic"}){
    _authType = authType;
  }

  /*
    Declare variables for later use
  */
  Uri _url;
  String _clientId;
  String _callbackUrlScheme;
  File _file;
  Map _tokenBody;
  Map _email;
  String _authType = "Generic";
  String _testResult;
 

  /*
    This is the filename of the json file where user data (tokens, email, etc.)
    will be stored.
  */
  final _filename = "AuthData.json";

  /*
    This are the getters for the previously declared variables
  */
  Uri get url{
    return _url;
  }

  String get clientId{
    return _clientId;
  }

  String get callbackUrlScheme{
    return _callbackUrlScheme;
  }

  Map get tokenBody{
    return _tokenBody;
  }
  
  setTokenBody(Map tokenBody){
    _tokenBody = tokenBody;
  }

  Map get email{
    return _email;
  }

  File get file{
    return _file;
  }

  setFile(File file){
    _file = file;
  }

  String get filename{
    return _filename;
  }

  String get authType{
    return _authType;
  }

  setAuthType(String authType){
    _authType = authType;
  }

  String get testResult{
    return _testResult;
  }
  
  setTestResult(String testResult){
    _testResult = testResult;
  }

  
  /*
    This function constructs the url where the oAuth request will be sent
  */
  setUrl(String website, String authExtension, String clientId, String redirect, {String responseType='token', String scopes, String tokenAddress}){
    _clientId = clientId;
    _callbackUrlScheme = redirect;
    if(scopes != null){
      _url = Uri.https(website, authExtension, {
          'response_type': responseType,
          'client_id': _clientId,
          'redirect_uri': '$_callbackUrlScheme:/',
          'scope': scopes,
        });
    }else{
      _url = Uri.https(website, authExtension, {
          'response_type': responseType,
          'client_id': _clientId,
          'redirect_uri': '$_callbackUrlScheme:/',
        });
    }
  }
  
  /*
    This function performs the authentication using FlutterWebAuth
    package: https://pub.dev/packages/flutter_web_auth
  */
  performAuth() async{
    
    // Present authentication display to user (ie. signin form)
    // if test variable not null, skip display and provide test result instead
    var result = "";
    bool lowIOS = await detectLowIOS();

    // if beyond flutter_web_auth's compatibility (flutter_web_auth only supports IOS 11+)
    if(lowIOS){
      openURLSwiftNative();
      return;
    } 

    if(_testResult == null){
      result = await FlutterWebAuth.authenticate(url: _url.toString(), callbackUrlScheme: _callbackUrlScheme);
    } else{
      result = _testResult;
    }

    if (result == null || result == 'null'){
      throw new NoResponseError();
    }
    
    // Extract token from result 
    var token = Uri.parse(result).queryParameters['access_token'];
  
    if(token == null){
      if(Uri.parse(result).queryParameters['error'] != null){
        throw new BadResponseError();
      }
      throw new NoResponseError();
    }
    
    /*
      Write the token into a file
      And stores the file locally in the device
    */
    Map<String, dynamic> temp = new Map();
    _tokenBody = new Map();
    temp['\"access_token\"'] = "\"" + token.toString() + "\"";
    temp['\"authType\"'] = "\"" + _authType + "\"";

    _tokenBody['access_token'] = token;
    _tokenBody['authType'] = _authType;
    
    _file = await localFile(_filename);
    _file.writeAsString(temp.toString());
  }

  /*
    This is responsible for retrieving the token from the file
  */
  Future<String> getToken() async {
    if(_tokenBody != null){
      return _tokenBody['access_token'];
    }

    if(_file == null){
      _file = await localFile(_filename);
    }

    if(await _file.exists()){
      String contents = await _file.readAsString(); 
      var contBody = jsonDecode(contents);
      if(contBody['authType'] != _authType){
        throw new WrongAuthTypeError();
      }
      return contBody['access_token'];
    }

    throw new FileDNEError();
  }

  /*
    This is responsible for deleting the token
    As of now, to do its purpose, it deletes the file entirely
  */
  deleteToken() async {
    if(_file == null){
      _file = await localFile(_filename);
    }
    if(await _file.exists()){
      _file.delete();
    }
  }

} // end of Auth class