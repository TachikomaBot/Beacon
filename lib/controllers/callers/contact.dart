import 'dart:io';
import 'package:Beacon/controllers/helpers/contact.dart';
import 'package:Beacon/controllers/helpers/store.dart';

/*
  This sets up existing contacts so that it is available in the code via ContactManager
*/
setupContactManager() async{
  final filename = "ContactData.json";
  File _file = await localFile(filename);

  if(_file.existsSync()) await readContactFromFile();
}