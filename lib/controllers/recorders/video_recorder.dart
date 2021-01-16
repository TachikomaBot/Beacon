import 'dart:async';
import 'dart:io';
import 'package:Beacon/controllers/callers/record.dart';
import 'package:Beacon/controllers/helpers/error.dart';
import 'package:Beacon/controllers/uploaders/file_uploader.dart';
import 'package:Beacon/router.dart';
import 'package:Beacon/views/screens/video_capture.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:Beacon/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class VideoRecorder extends StatefulWidget{
  @override
  _VideoRecorder createState() => _VideoRecorder();
}

class _VideoRecorder extends State<VideoRecorder>{

  //Declare variables for future use
  CameraController cameraController;
  String videoPath;
  String videoName;
  int cameraId = 0;
  bool isRecordingVideoEvent = false;
  String recordStateDisp = "";

  final fileUploader = FileUploader();
  IconData flashIcon = Icons.flash_off;
  int flashSwitch = 0;
  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState(){
    super.initState();
    cameraController = new CameraController(cameras[cameraId], ResolutionPreset.medium);
    cameraController.initialize().then((_) {
      if(!mounted){
        return;
      }
      setState(() {
        //start the video recording right away
        _onVideoRecordButtonPressed();
      });
    });

    //to send notification when saved
    
    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings();
    notifications.initialize(
      InitializationSettings(settingsAndroid, settingsIOS));
  }

  @override
  void dispose(){
    cameraController?.dispose();
    super.dispose();
  }

  //This was placed to handle a bug concerning camera disposal
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (cameraController != null) {
        onNewCameraSelected(cameraController.description);
      }
    }
  }

  //This is called by UI to start the recording
  _onVideoRecordButtonPressed(){
    startVideoRecording().then((String filePath){
      if(mounted) setState(() {});
      if(filePath != null) {
        print('Saving video to $filePath');

        setState(() {
          isRecordingVideoEvent = true;
          recordStateDisp = "Recording in Progress";
        });
      }
    });
  }

  //This is called by the UI to stop the recording
  _onStopButtonPressed() {
    stopVideoRecording().then((_) {
      if (mounted) setState(() {});
      print('Video is saved to $videoPath');

      //add video to TransmitManager to be saved
      queueToSave(timestamp(), videoPath);

      setState(() {
          isRecordingVideoEvent = false;
          recordStateDisp = "Saving Recording...";
      });
      Navigator.pushReplacementNamed(context, controlCenterRoute);
    });

  }

  // This is called when flash icon is pressed
  _onTorchButtonPressed(){

    switch (flashSwitch) {

      // turn on light 
      case 0:
        flashSwitch = 1;

        setState(() {
          flashIcon = Icons.flash_on;
        });

        cameraController.flash(true);
        break;

      //turn off light
      case 1:
        flashSwitch = 0;

        setState(() {
          flashIcon = Icons.flash_off;
        });
        
        cameraController.flash(false);
        break;
    }
    
  }

  //This is the timestamp for the videos. Will be moved to its own helper folder file
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  //This is for catching errors on Camera 
  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async{
    if(cameraController != null){
      await cameraController.dispose();
    }

    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );

    cameraController.addListener((){
      if(mounted) setState(() {});
      if(cameraController.value.hasError){
        print('Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e){
      _showCameraException(e);
    }

    if(mounted){
      setState(() {});
    }
  }
  
  //This starts the recording
  Future<String> startVideoRecording() async {
    if(!cameraController.value.isInitialized){
      print('Error: camera is not initialized');
      return null;
    }

    final Directory extDir = await getTemporaryDirectory();
    final String dirPath = '${extDir.path}/Movies/beacon_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    if(cameraController.value.isRecordingVideo){
      return null;
    }

    try{
      videoPath = filePath;
      videoName = timestamp() + '.mp4';
      await cameraController.startVideoRecording(filePath);
    
    } on CameraException catch(e){
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  //This stops the recording
  Future<void> stopVideoRecording() async {
    if (!cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      await cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (!cameraController.value.isInitialized) {
      return new Container();
    }

    return VideoCaptureScreen(
      size: size, 
      flashIcon: flashIcon,
      cameraController: cameraController,
      recordStateDisp: recordStateDisp,
      onStopButtonPressed: _onStopButtonPressed,
      onTorchButtonPressed: _onTorchButtonPressed
    );
  }

}

redirectToVideoScreen(BuildContext context){
  Vibration.vibrate(duration: 50); //vibrate
  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoCaptureScreen())); //redirect
}