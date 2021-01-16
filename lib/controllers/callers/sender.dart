import 'dart:io';
import 'package:Beacon/controllers/callers/email.dart';
import 'package:Beacon/controllers/callers/sms.dart';
import 'package:Beacon/controllers/callers/twilio.dart';
import 'package:Beacon/controllers/geolocation/geolocation.dart';
import 'package:Beacon/controllers/helpers/notifications.dart';
import 'package:Beacon/controllers/managers/contact_manager.dart';
import 'package:Beacon/models/contact.dart';
import 'package:geolocator/geolocator.dart';


/*
  This indirectly calls SmsSender class, TwilioSender class and EmailSender's subclasses (GmailSender).
  ALSO this calls the ContactManager class which contains all the user's given contacts.

  AND, this calls Geolocation Class to obtain lat and long of user to be sent with the message

  MOREOVER, this displays a toast if all possible senders are successful (iPhone's can't use SmsSender).
  Else, this should call a notification when sending messages were successful when app is on the foreground.

*/

sendMessages() async{

  //collect all contacts
  final contactManager = ContactManager();
  List<Contact> contacts = contactManager.fetchContacts();

  //get geolocation
  // Position lastKnownCoords = await Geolocation().getLastKnownCoords();

  //define message
  String msgBody = "This is an alert from Beacon";

  //send message to contacts
  contacts.forEach((contact) {
    
    if(Platform.isAndroid) {
      sendSMS(contact.phoneNumber, msgBody);
    } else{
      sendTwilio(contact.phoneNumber, msgBody);
    }
    
    sendGmail(contact.email, msgBody);
    showMessageNotification();
  });

}