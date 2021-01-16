import 'package:Beacon/controllers/senders/sms_sender.dart';
import 'package:Beacon/controllers/senders/twilio_sender.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();

  test("Test send SMS", (){
    SmsSender sender = SmsSender();
    sender.sendSMS('123', 'hello');
  });

  test("Test send Twilo SMS", () async{
    await DotEnv().load('.env');
    TwilioSender sender = TwilioSender();
    sender.sendMessage('123', 'hello');
  });
}