import 'package:Beacon/controllers/managers/transmit_manager.dart';
import 'package:Beacon/models/transmitable.dart';
import 'package:Beacon/models/video_file.dart';
import 'dart:io';

/*
  This will be called in startVideoRecording in VideoRecorder controller.
  This puts an ongoing video (filePath) to the TransmitManager to ready for saving.
*/
queueToSave(String fileName, String filePath){
  //Create a File out of filePath
  File file = new File(filePath);

  //Create VideoFile that will be packaged with Transmittable
  VideoFile videoFile = new VideoFile();
  videoFile.setFileName(fileName);
  videoFile.setFile(file);
  videoFile.setFileLength(file.lengthSync().toString());

  //Create Transmittable
  Transmitable transmitable = new Transmitable(videoFile);

  //Add to TransmitManager
  TransmitManager().add(transmitable);
}