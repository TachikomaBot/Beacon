import 'dart:convert';
import 'package:http/http.dart' as http;

/*
  This is the superclass for all email senders (gmail, ymail, hotmail).
  Only gmail is implemented right now (03/26/2020)
*/
class EmailSender {
  
  //constructor
  EmailSender();

  /*
    This config the header for sending emails
  */
  Map configEmailHeader(Map header){
    header['Accept'] = 'application/json';
    header['Content-type'] = 'application/json';

    return header;
  }

  /*
    This creates the message body of the email which will be sent with the header on the post request
  */
  String createEmailMessage(String userId, String sendTo, String msgBody){
    print("creating email message for $userId");

    var from = userId;
    var to = sendTo;
    var subject = 'test send email';

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

    return body;
  }

  /*
     This creates a post request to the url and actually send the email
  */
  // sendEmail(Map header,  String body) async{
    
  //   final url = "https://postman-echo.com/post";

  //   //post request
  //   final http.Response response = await http.post(
  //       url,
  //       headers: header,
  //       body: body
  //   );

  //   print(response);
  // }
}