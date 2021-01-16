// import 'package:Beacon/controllers/helpers/auth.dart';
// import 'package:Beacon/controllers/helpers/email.dart';
import 'package:Beacon/controllers/senders/gmail_sender.dart';

/*
  This calls the GmailEmailSender class to actually send the email to a given 'sendTo' email address
*/
sendGmail(String sendTo, String msgBody) async {
  
  // final sendFrom = await generateEmailAddress();
  // final header = await generateHeader();
  final sender = GmailEmailSender();
  
  //config and generate header for email
  // Map newHeader = sender.configEmailHeader(header);

  //fix email body message that will be sent with the post request
  // String emailBody = sender.createEmailMessage(sendFrom, sendTo, msgBody);

  //send the email
  await sender.sendEmail(sendTo, msgBody);
}