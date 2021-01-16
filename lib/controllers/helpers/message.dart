  
import 'dart:io';
import 'package:Beacon/controllers/callers/email.dart';
import 'package:Beacon/controllers/callers/sms.dart';
import 'package:Beacon/controllers/callers/twilio.dart';
import 'package:Beacon/controllers/geolocation/geolocation.dart';
import 'package:Beacon/controllers/managers/contact_manager.dart';
import 'package:Beacon/models/contact.dart';

/*
  This indirectly calls SmsSender class, TwilioSender class and EmailSender's subclasses (GmailSender).
  ALSO this calls the ContactManager class which contains all the user's given contacts.
  AND, this calls Geolocation Class to obtain lat and long of user to be sent with the message
  MOREOVER, this displays a toast if all possible senders are successful (iPhone's can't use SmsSender).
  Else, this should call a notification when sending messages were successful when app is on the foreground.
*/

sendMessages(){

  //collect all contacts
  final contactManager = ContactManager();
  List<Contact> contacts = contactManager.fetchContacts();

  String messageBody = 'Hey! I\'m in trouble right now at this location.\n' + Geolocation().getLastKnownCoords().toString() +
      '\nThis is an automated message sent by the Beacon App to let you know I\'ve had an altercation with Law Enforcement and I might need your help.';

  //send message to contacts
  contacts.forEach((contact) {
    if(Platform.isAndroid) sendSMS(contact.phoneNumber, messageBody);
    sendTwilio(contact.phoneNumber, messageBody);
    sendGmail(contact.email, messageBody);
    
  });
}