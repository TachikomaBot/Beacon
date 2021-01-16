import 'dart:convert';
import 'package:Beacon/controllers/helpers/auth.dart';
import 'package:Beacon/controllers/helpers/email.dart';
import 'package:Beacon/controllers/senders/email_sender.dart';
import 'package:http/http.dart' as http;

class GmailEmailSender extends EmailSender{
  
  //singleton
  static final GmailEmailSender _singleton = new GmailEmailSender._internal();

  factory GmailEmailSender(){
    return _singleton;
  }

  GmailEmailSender._internal();
  
  /*
    Override method from superclass to update with gmail url
  */
  sendEmail(String sendTo,  String msgBody) async{
    
    final sendFrom = await generateEmailAddress();
    final header = await generateHeader();
    
    header['Accept'] = 'application/json';
    header['Content-type'] = 'application/json';

    var from = sendFrom;
    var to = sendTo;
    var subject = 'Beacon Alert';
    var message = msgBody;
    var content =
    '''
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
to: $to
from: $from
subject: $subject

$message
''';

    var bytes = utf8.encode(content);
    var base64 = base64UrlEncode(bytes);
    var body = json.encode({'raw': base64});

    String url = 'https://www.googleapis.com/gmail/v1/users/me/messages/send';

    final http.Response response = await http.post(
        url,
        headers: header,
        body: body
    );
    if (response.statusCode != 200) {

      print('error: ' + response.statusCode.toString());
      print(url);
      print(json.decode(response.body));

      return;
    }

    //if email sending 
    final Map<String, dynamic> data = json.decode(response.body);
    print('ok: ' + response.statusCode.toString());
    print(data);
  }
}
