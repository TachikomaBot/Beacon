import 'package:flutter_test/flutter_test.dart';
import 'package:Beacon/controllers/auth/auth.dart';
import 'package:Beacon/controllers/auth/google_auth.dart';
import 'package:Beacon/controllers/helpers/error.dart';
import 'dart:io';
import 'package:mockito/mockito.dart';

class MockFile extends Mock implements File{}

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  MockFile mockFile = MockFile();

//Initialization related tests
  test("Test setUrl", (){
    Auth auth = new Auth();
    String website = "www.website.com";
    String authExtension = "/oauth/";
    String clientId = "CLIENT_ID";
    String redirect = "com.example.app";
    String response = "type";
    String scopeList = "access_level";

    auth.setUrl(website, authExtension, clientId, redirect, responseType: response, scopes: scopeList);

    expect(auth.clientId, clientId);
    expect(auth.callbackUrlScheme, redirect);
    expect(auth.url.toString(), "https://$website$authExtension?response_type=$response&client_id=$clientId&redirect_uri=$redirect%3A%2F&scope=$scopeList");
  });

  test("Test GoogleAuth setUrl", (){
    GoogleAuth auth = new GoogleAuth();
    String website = "www.website.com";
    String authExtension = "/oauth/";
    String clientId = "CLIENT_ID";
    String redirect = "com.example.app";
    String response = "type";
    String scopeList = "access_level";
    String tokensite = "www.token.com";

    auth.setUrl(website, authExtension, clientId, redirect, responseType: response, scopes: scopeList, tokenAddress: tokensite);

    expect(auth.clientId, clientId);
    expect(auth.callbackUrlScheme, redirect);
    expect(auth.tokenAddress, tokensite);
    expect(auth.url.toString(), "https://$website$authExtension?response_type=code&client_id=$clientId&redirect_uri=$redirect%3A%2F&scope=$scopeList");
  });


// Testing getToken
  test("Test getToken File DNE", () async {
    Auth auth = new Auth();
    String s = "";
    
    when(mockFile.exists()).thenAnswer((_) => Future.value(false));
    auth.setFile(mockFile);

    auth.setUrl(s, s, s, s);

    try {
      await auth.getToken();
      }
    catch(e){
      expect(e.toString(), (new FileDNEError()).toString());
    } finally{
      reset(mockFile);
    }  
  });

  test("Test getToken File DNE for GoogleAuth", () async {
    GoogleAuth auth = new GoogleAuth();
    String s = "";

    when(mockFile.exists()).thenAnswer((_) => Future.value(false));

    auth.setUrl(s, s, s, s);
    auth.setFile(mockFile);

    try {
      await auth.getToken();
      }
    catch(e){
      expect(e.toString(), (new FileDNEError()).toString());
    }finally{
      reset(mockFile);
    }  
  });

  test("Test getToken ", () async {
    Auth auth = new Auth();
    String s = "";
    
    String testToken = "someTokenString";
    String testJson = "{\"authType\" : \"Generic\", \"access_token\" : \"$testToken\"}";

    when(mockFile.exists()).thenAnswer((_) => Future.value(true));
    when(mockFile.readAsString()).thenAnswer((_) => Future.value(testJson));
    

    auth.setUrl(s, s, s, s);
    auth.setFile(mockFile);

    try{
      expect(await auth.getToken(), testToken);
    } finally {
      reset(mockFile);
    }
  });

  test("Test getToken GoogleAuth", () async {
    GoogleAuth auth = new GoogleAuth();
    String s = "";
    
    String testToken = "someTokenString";
    String testJson = "{\"authType\" : \"Google\", \"expiration\" : \"9999999999999\", \"access_token\" : \"$testToken\"}";

    when(mockFile.exists()).thenAnswer((_) => Future.value(true));
    when(mockFile.readAsString()).thenAnswer((_) => Future.value(testJson));
    
    auth.setUrl(s, s, s, s);
    auth.setFile(mockFile);

    try {
    expect(await auth.getToken(), testToken);
    } finally {
      reset(mockFile);
    }
  });


// Testing performAuth

  test("Test performAuth No Response", () async {
    Auth auth = new Auth();
    String s = "";
    String result = "";

    auth.setUrl(s, s, s, s);
    auth.setTestResult(result);

    try {
      await auth.performAuth();
      }
    catch(e){
      expect(e.toString(), (new NoResponseError()).toString());
    }
  });

  test("Test performAuth Null Response", () async {
    Auth auth = new Auth();
    String s = "";
    String result = "null";

    auth.setUrl(s, s, s, s);
    auth.setTestResult(result);

    try {
      await auth.performAuth();
      }
    catch(e){
      expect(e.toString(), (new NoResponseError()).toString());
    }
  });

  test("Test performAuth Bad Response", () async {
    Auth auth = new Auth();
    String s = "";
    String result = "www.website.com:/?error=errorcode";

    auth.setUrl(s, s, s, s);
    auth.setTestResult(result);

    try {
      await auth.performAuth();
      }
    catch(e){
      expect(e.toString(), (new BadResponseError()).toString());
    }
  });

  test("Test performAuth and getToken together", () async{
    Auth auth = new Auth();
    String s = "";
    String testToken = "someTokenString";
    String testJson = "{\"authType\" : \"Generic\", \"access_token\" : \"$testToken\"}";

    when(mockFile.exists()).thenAnswer((_) => Future.value(true));
    when(mockFile.readAsString()).thenAnswer((_) => Future.value(testJson));

    auth.setUrl(s, s, s, s);
    auth.setFile(mockFile);

    try {
      await auth.performAuth();
      expect(await auth.getToken(), testToken);
      }
    catch(e){} 
    finally{
      reset(mockFile);
    }
  });

  test("Test performAuth No Response for GoogleAuth", () async {
    GoogleAuth auth = new GoogleAuth();
    String s = "";
    String result = "";

    auth.setUrl(s, s, s, s);
    auth.setTestResult(result);

    try {
      await auth.performAuth();
      }
    catch(e){
      expect(e.toString(), (new NoResponseError()).toString());
    }
  });

  test("Test performAuth Null Response for GoogleAuth", () async {
    GoogleAuth auth = new GoogleAuth();
    String s = "";
    String result = "null";

    auth.setUrl(s, s, s, s);
    auth.setTestResult(result);

    try {
      await auth.performAuth();
      }
    catch(e){
      expect(e.toString(), (new NoResponseError()).toString());
    }
  });

  test("Test performAuth Bad Response for GoogleAuth", () async {
    GoogleAuth auth = new GoogleAuth();
    String s = "";
    String result = "www.website.com:/?error=errorcode";

    auth.setUrl(s, s, s, s);
    auth.setTestResult(result);

    try {
      await auth.performAuth();
      }
    catch(e){
      expect(e.toString(), (new BadResponseError()).toString());
    }
  });

  test("Test performAuth and getToken for GoogleAuth", () async {
    GoogleAuth auth = new GoogleAuth();
    String s = "";
    String result = "www.website.com:/?code=someCode";
    String testToken = "someTokenString";
    String time = ((DateTime.now().add(Duration(seconds: 100))).millisecondsSinceEpoch).toString();
    String fileStr = "{\"access_token\" : \"$testToken\", \"expires_in\" : \"100\", \"refresh_token\" : \"someRefreshToken\", \"expiration\" : \"$time\"}";
    String response = "{\"access_token\" : \"$testToken\", \"expires_in\" : \"100\", \"refresh_token\" : \"someRefreshToken\"}";

    when(mockFile.exists()).thenAnswer((_) => Future.value(true));
    when(mockFile.readAsString()).thenAnswer((_) => Future.value(fileStr));

    auth.setUrl(s, s, s, s);
    auth.setTestResult(result);
    auth.setTestResponse(response);
    auth.setFile(mockFile);

    try {
      await auth.performAuth();
      expect(await auth.getToken(), testToken);
      }
    catch(e){} 
    finally{
      reset(mockFile);
    }
  });
}