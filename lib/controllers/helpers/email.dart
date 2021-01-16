import 'package:Beacon/controllers/auth/google_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/* 
  This will generate/return the Email Address string needed for sending via gmail.
  This can be potentially moved up to EmailSender if other email services 
  have the same structure
*/
Future<String> generateEmailAddress() async{
  var token = await GoogleAuth().getToken();
  var url = 'https://www.googleapis.com/oauth2/v1/userinfo?access_token=';
  
  final response = await http.get(url + token);
  final data = json.decode(response.body) as Map<String, dynamic>;

  var email = data['email'];
  
  return email;
}