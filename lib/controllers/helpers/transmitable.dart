import 'dart:convert';
import 'dart:io';
import 'package:Beacon/controllers/helpers/store.dart';
import 'package:Beacon/controllers/managers/transmit_manager.dart';
import 'package:Beacon/models/transmitable.dart';

/* 
  This 'updates' BeaconVideoTasksData.json by rewriting the file
*/
writeTaskToFile() async {

  //declare variables for later use
  final transmitManager = TransmitManager();
  final filename = "BeaconVideoTasksData.json";
  Map<String, dynamic> temp = new Map();

  //delete file
  deleteFile(filename);

  //collect all tasks in Transmit Manager
  List<Transmitable> tasks = transmitManager.tasks;
  List jsonList = [];

  tasks.forEach((task) => jsonList.add(task.toJson()));
  
  //config temp
  temp['taskList'] = jsonList;

  //create/recreate file and write to it
  File file = await localFile(filename);
  file.writeAsStringSync(temp.toString());
}

/*
  This reads all data from BeaconVideoTasksData.json and adds it to transmitManager
*/
readTasksFromFile() async{
  //declare variables for later use
  final transmitManager = TransmitManager();
  final filename = "BeaconVideoTasksData.json";
  File _file = await localFile(filename);

  String contents = _file.readAsStringSync();

  //parse
  var contentBody = jsonDecode(contents)['taskList'] as dynamic;
  List<Transmitable> tasks = contentBody.map((task) => Transmitable.fromJson(task)).toList();

  //add to Manager
  tasks.forEach((task) => transmitManager.add(task));
}

/* 
  This deletes a file with a given filename
*/
deleteFile(String filename) async{
  File _file = await localFile(filename);
  if(_file.existsSync()) _file.delete();
}