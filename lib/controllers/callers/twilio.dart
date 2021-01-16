import 'package:Beacon/controllers/senders/twilio_sender.dart';

/*
  This calls TwilioSender which sends a Twilio SMS to the 'sendTo' if internet connectivity exists
*/
sendTwilio(String sendTo, String msgBody){
  final sender = TwilioSender();
  sender.sendMessage(sendTo, msgBody);
}