import 'dart:convert';
import 'dart:io';
import 'package:Beacon/controllers/helpers/store.dart';
import 'package:Beacon/controllers/managers/contact_manager.dart';
import 'package:Beacon/models/contact.dart';

/* 
  This 'updates' ContactData.json by rewriting the file
*/
writeContactToFile() async {

  //declare variables for later use
  final contactManager = ContactManager();
  final filename = "ContactData.json";
  Map<String, dynamic> temp = new Map();

  //delete file
  deleteFile(filename);

  //collect all data from ContactManager that will be written to file
  List<Contact> contacts = contactManager.fetchContacts();

  //config temp
  for(var index = 1; index <= contacts.length; index++){
    temp['\"firstName$index\"'] = "\"" + contacts[index-1].firstName + "\"";
    temp['\"lastName$index\"'] = "\"" + contacts[index-1].lastName + "\"";
    temp['\"phoneNumber$index\"'] = "\"" + contacts[index-1].phoneNumber + "\"";
    temp['\"email$index\"'] = "\"" + contacts[index-1].email + "\"";
    temp['\"occupation$index\"'] = "\"" + contacts[index-1].occupation + "\"";
    temp['\"relationship$index\"'] = "\"" + contacts[index-1].relationship + "\"";
  }

  //create/recreate file and write to it
  File file = await localFile(filename);
  file.writeAsStringSync(temp.toString());
}

/*
  This reads all data from Contact Data.json. This will whenever app is loaded (not on foreground) which will be on initState() of ControlCenterScreen()
*/
readContactFromFile() async{

  //declare variables for later use
  final contactManager = ContactManager();
  final filename = "ContactData.json";
  File _file = await localFile(filename);

  String contents = _file.readAsStringSync();
  var contentBody = jsonDecode(contents);

  for(var index = 1; index <= 3; index++){
    if(contentBody['firstName$index'].toString() != "null"){

      // extract data and make Contact object
      Contact contact = Contact();
      contact.firstName = contentBody['firstName$index'].toString();
      contact.lastName = contentBody['lastName$index'].toString();
      contact.phoneNumber = contentBody['phoneNumber$index'].toString();
      contact.email = contentBody['email$index'].toString();
      contact.occupation = contentBody['occupation$index'].toString();
      contact.relationship= contentBody['relationship$index'].toString();

      // add Contact to contacts list in ContactManager
      contactManager.addContact(contact);
    }
  }
}

/* 
  This deletes a file with a given filename
*/
deleteFile(String filename) async{
  File file = await localFile(filename);
  if(file.existsSync()) file.delete();
}