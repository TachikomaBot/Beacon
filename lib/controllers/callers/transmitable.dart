import 'dart:io';
import 'package:Beacon/controllers/helpers/store.dart';
import 'package:Beacon/controllers/helpers/transmitable.dart';

setupTransmitManager() async{
  final filename = "BeaconVideoTasksData.json";
  File _file = await localFile(filename);

  if(_file.existsSync()) await readTasksFromFile();
}