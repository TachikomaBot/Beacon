import 'package:Beacon/controllers/helpers/hexcolor.dart';
import 'package:Beacon/controllers/helpers/message.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class VideoCaptureScreen extends StatefulWidget{

  final size;
  final IconData flashIcon;
  final CameraController cameraController;
  final String recordStateDisp;
  final Function onStopButtonPressed;
  final Function onTorchButtonPressed;

  VideoCaptureScreen({
    this.size,
    this.flashIcon, 
    this.cameraController,
    this.recordStateDisp,
    this.onStopButtonPressed,
    this.onTorchButtonPressed
  });

  @override
  _VideoCaptureScreen createState() => _VideoCaptureScreen();
}

class _VideoCaptureScreen extends State<VideoCaptureScreen>{

  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings();
    notifications.initialize(
      InitializationSettings(settingsAndroid, settingsIOS));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: Key('video-screen'),
      child: Material(
        child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          ClipRect(
            child: Container(
                child: Transform.scale(
                  scale: widget.cameraController.value.aspectRatio / widget.size.aspectRatio,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: widget.cameraController.value.aspectRatio,
                      child: CameraPreview(widget.cameraController),
                    ),
                  ),
                ),
              ),
          ),
          
          Positioned(
            top: 0.0,
            right: 0.0,
            left: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [blueColor, Colors.transparent] 
                )
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Text(
                          widget.recordStateDisp,
                          key: Key('record-state'),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                          textScaleFactor: 1.5,
                        ),
                )
            ),

          ),
          Positioned.fill(
            bottom: 25.0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                key: Key('stop-btn'),
                onPressed: widget.onStopButtonPressed,
                child: Text('STOP'),
                backgroundColor: fleshColor
              ),
            ),
          ),

          //this is the flash mode selector
          Positioned(
            bottom: 40,
            right: 25,
            child: InkWell(
              child: Icon(
                widget.flashIcon,
                color: Colors.white,
                size: 30.0
              ),
              onTap: widget.onTorchButtonPressed
            )
          ),

          //this sends the emergency message during video capture
          Positioned(
            bottom: 35,
            left: 30,
            child: InkWell(
              child: Icon(
                Icons.message,
                color: Colors.white,
                size: 30.0
              ),
              onTap: (){
                //call send message (maybe add restriction so user cannot spam his/her contacts)
                sendMessages();
              }
            )
          )
          
          ],
        )
      
      )
    );
  }

}


