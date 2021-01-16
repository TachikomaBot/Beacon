import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:Beacon/controllers/auth/auth.dart';
import 'package:Beacon/controllers/helpers/auth.dart';
import 'package:Beacon/controllers/helpers/detect_os.dart';
import 'package:Beacon/controllers/helpers/error.dart';
import 'package:Beacon/controllers/helpers/store.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'dart:convert' show jsonDecode;
import 'package:http/http.dart' as http;

class GoogleAuth extends Auth{
  /*
    This class will be singleton so we can its only instance globally.
  */
  static final GoogleAuth _singleton = new GoogleAuth._internal();

  factory GoogleAuth(){
    return _singleton;
  }

  GoogleAuth._internal({ String authType = "Google"}){
    setAuthType(authType);
  }

  // extra variable for google
  String _tokenAddress;

  // extra testing variable for GoogleAuth
  String _testResponse;

  //getter and setter for tokenAddress
  String get tokenAddress{
    return _tokenAddress;
  }
  
  setTestResponse(String testResponse){
    _testResponse = testResponse;
  }

  // override Auth's setUrl with Google auth specs
  setUrl(String website, String authExtension, String clientId, String redirect, {String responseType='token', String scopes, String tokenAddress}){
    super.setUrl(website, authExtension, clientId, redirect, responseType: 'code', scopes: scopes);
    _tokenAddress = tokenAddress;
  }

  // override Auth's performAuth with Google auth specs
  performAuth() async{
    
    //Declare variables for future use
    var result;
    bool lowIOS = await detectLowIOS();

    // if beyond flutter_web_auth's compatibility (flutter_web_auth only supports IOS 11+)
    if(lowIOS){
      openURLSwiftNative();
      return;
    } 

    if(testResult == null){
      result = await FlutterWebAuth.authenticate(url: url.toString(), callbackUrlScheme: callbackUrlScheme);
    } else {
      result = testResult;
    }

    if (result == null || result == 'null'){
      throw new NoResponseError();
    }

    /* 
      Code is implemented this way so that performAuth isn't doing too much (separation of concerns)
      For Layman:
        1. parse the result from either uni_links or flutter_web_auth (dependent on device)
        2. parseResult will return a code
        3. getResponse will return a response using code
        4. getAccessToken will return a body of auth data using response
        5. setToken will put all data from body into a temp Map
        6. storeToken will store all auth data to a local file in the device
    */
    await parseResultHandler(result);
  
  } 

  /*
    This will parse the result from either flutter_web_auth or uni_links
  */
  parseResultHandler(var result) async{
    var code = Uri.parse(result).queryParameters['code'];

    if(code == null){
      if(Uri.parse(result).queryParameters['error'] != null){
      throw new BadResponseError();
    }
      throw new NoResponseError();
    }

    //next handler
    await getResponseHandler(code);
  }

  /* 
    This will get the response from post request to token address
  */
 getResponseHandler(String code) async{

    // if test variable not null, instead use test response instead
    var response;

    if(_testResponse != null){
      response = new http.Response(_testResponse , 200);
    } else {
      response = await http.post(_tokenAddress, body: {
        'client_id': clientId,
        'redirect_uri': '$callbackUrlScheme:/',
        'grant_type': 'authorization_code',
        'code': code,
      });
    } 

    if (response == null){
      throw new NoResponseError();
    }

    //next handler
    await getAccessTokenHandler(response);
  }

  /*
    This will get the access token from the response
  */
  getAccessTokenHandler(var response) async{

    var body = jsonDecode(response.body);
      if(body['access_token'] == null || body['expires_in'] == null || body['refresh_token'] == null){
        if(body['error'] == null){
          throw new NoResponseError();
        } else{
          throw new BadResponseError();
        }
    }

    body['expiration'] = ((DateTime.now().add(Duration(seconds: int.parse(body['expires_in'].toString())))).millisecondsSinceEpoch).toString();
    body['authType'] = authType;

    //next handler
    await setToken(body);
  }

  /*
    This will set the tokenBody of class from all data retrieved inn getAccessToken
  */
  setToken(var body) async{
    Map<String, dynamic> temp = new Map(); 
    body.forEach((String k,v) => temp["\""+k+"\""] = "\""+v.toString()+"\""); // so it's easier to read and decode from file later
    setTokenBody(body);

    //next handler
    await storeToken(temp);
  }

  /*
    This will store the token in a local file
  */
  storeToken(Map<String, dynamic> temp) async{
    File file = await localFile(filename);
    setFile(file);
    super.file.writeAsString(temp.toString());
  }

  // Override Auth's getToken
  Future<String> getToken() async {

    if(tokenBody != null){
      int now = DateTime.now().millisecondsSinceEpoch;
      var expirationVar = tokenBody['expiration'];
      if(now >= int.parse(expirationVar)){
        // nothing happens, but this will allow fall thru to the block where refreshing token can occur
      } else if (expirationVar != null) {
        return tokenBody['access_token'];
      }
    }

    // if tokenBody is null, then the same as above "nothing happens" occurs
    if(file == null){
      File file = await localFile(filename);
      setFile(file);
    }

    if(await file.exists()){
      String contents = await file.readAsString(); 
      var contBody = jsonDecode(contents);

      if(contBody['authType'] != authType){
        throw new WrongAuthTypeError();
      }
      
      int time = int.parse(contBody['expiration']);
      int now = DateTime.now().millisecondsSinceEpoch;
    
    // perform check again because we could have arrived here because app was off and file hadn't yet been read
    
    if(now >= time){ // refresh token

      final response = await http.post(_tokenAddress, body: {
        'refresh_token' : contBody['refresh_token'],
        'client_id': clientId,
        'grant_type': 'refresh_token',          
      });

      if (response == null){
        throw new NoResponseError();
      }

      var newBody = jsonDecode(response.body);

      if(newBody['access_token'] == null || newBody['expires_in'] == null || newBody['refresh_token'] == null){
        if(newBody['error'] == null){
          throw new NoResponseError();
        } else {
          throw new BadResponseError();
        }
      }

      contBody['expiration'] = ((DateTime.now().add(Duration(seconds: int.parse(newBody['expires_in'].toString())))).millisecondsSinceEpoch).toString();
      contBody['access_token'] = newBody['access_token'];
      contBody['refresh_token'] = newBody['refresh_token'];

      Map<String, dynamic> temp = new Map(); 
      
      contBody.forEach((String k,v) => temp["\""+k+"\""] = "\""+v.toString()+"\""); // so it's easier to read and decode from file later
      
      setTokenBody(contBody);
      file.writeAsString(temp.toString());
  
      return contBody['access_token'];

    } else {
        return contBody['access_token'];
      }
    }
    throw new FileDNEError();  
  } //end of getToken()

} //end of GoogleAuth class