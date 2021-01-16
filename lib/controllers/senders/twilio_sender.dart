import 'package:Beacon/controllers/helpers/twilio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class TwilioSender {
  
  //singleton
  static final TwilioSender _singleton = new TwilioSender._internal();

  factory TwilioSender(){
    return _singleton;
  }

  TwilioSender._internal();

  /*
    This sends the text message via twilio 
  */
  Future<Map> sendMessage(String number, String msgBody) async {
    
    //create data map based on arguments
    var data = {
      'body': msgBody,
      'from': '${DotEnv().env['TWILIO_SENDER_NUM']}',
      'to': number
    };

    var client = http.Client();

    //set url
    var url = '${DotEnv().env['TWILIO_SMS_API_BASE_URL']}/Accounts/${DotEnv().env['TWILIO_ACCOUNT_SID']}/Messages.json';

    //perform post request aka send the message via the url
    try {
      var response = await client.post(url, headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic ' + toAuthCredentials(DotEnv().env['TWILIO_ACCOUNT_SID'], DotEnv().env['TWILIO_AUTH_TOKEN'])
      }, body: {
        'From': data['from'],
        'To': data['to'],
        'Body': data['body']
      });

      return (json.decode(response.body));

    } catch (e) {
      return ({'Runtime Error': e});

    } finally {
      client.close();

    }
  }
}