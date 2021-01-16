import 'package:Beacon/controllers/senders/sms_sender.dart';

/*
  This calls the SmsSender class which sends sms text messages via Android
*/
sendSMS(String sendTo, String msgBody){
  final sender = SmsSender();
  sender.sendSMS(sendTo, msgBody);
}