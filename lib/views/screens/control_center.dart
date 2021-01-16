import 'package:Beacon/controllers/callers/sender.dart';
import 'package:Beacon/controllers/helpers/hexcolor.dart';
import 'package:Beacon/controllers/helpers/permission.dart';
import 'package:Beacon/router.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:worker_manager/executor.dart';
import 'package:worker_manager/runnable.dart';
import 'package:worker_manager/task.dart';

/*
  This is the Control Center Screen where the user 
*/
class ControlCenterScreen extends StatefulWidget{
  final ValueChanged<double> valueChanged;

  ControlCenterScreen({this.valueChanged});

  @override
  ControlCenterScreenState createState() => ControlCenterScreenState();

}

class ControlCenterScreenState extends State<ControlCenterScreen> with TickerProviderStateMixin{

  // Declare variables for later use
  AnimationController largeCircleController;
  AnimationController circleProgressController;
  AnimationController textController;
  Animation<double> height;
  Animation<double> opacity;
  Animation<double> rising;
  Animation<double> delayedAnimation;

  ValueNotifier<double> valueListener = ValueNotifier(.5);
  bool showIcons = false;
  bool actionPerformed = false;
  String responseText = 'this is a long string to test text wrapping';

  double circleSize = 100.0;

  void notifyParent() {
    if (widget.valueChanged != null) {
      widget.valueChanged(valueListener.value);
    }
  }

  @override
  void initState() {
    super.initState();
    requestPermissions(); //request permissions
    valueListener.addListener(notifyParent);
  
    largeCircleController = AnimationController(vsync: this, duration: Duration(milliseconds: 50))
    ..addListener(() {
      if (this.mounted) {
        setState(() {});
      }
    });
    circleProgressController = AnimationController(vsync: this, duration: Duration(milliseconds: 3000))
      ..addListener(() {
        if (this.mounted) {
          setState(() {
            if(circleProgressController.status == AnimationStatus.completed) {
              responseText = 'Sending Alerts and Starting Recording';
              textController.forward().orCancel;
              actionPerformed = true;

              //run sendMessages in the Isolate
              final task = Task(runnable: Runnable(fun1:sendMessages()));
              Executor().addTask(task: task).then((result){
                print(result);
              }).catchError((error) {
                print((error));
              });

              Future.delayed(const Duration(milliseconds: 3000), () {
                circleProgressController.stop();
                largeCircleController.stop();
                textController.stop();
                Navigator.of(context).pushReplacementNamed('/recording');
              });
            }
          });
        }
    });
    textController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
      ..addListener(() {
        if (this.mounted) {
          setState(() {
            if (textController != null && textController.status == AnimationStatus.completed) {
              Future.delayed(const Duration(seconds: 1), () {
                textController.reverse().orCancel;
              });
            }
          });
        }
      });

    height = Tween(begin: 1.0, end: 6.4).animate(new CurvedAnimation(
        parent: largeCircleController,
        curve: Curves.linear
    ));

    delayedAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: circleProgressController,
            curve: Interval(0.33, 1.0, curve: Curves.easeIn)
        ));

    opacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: textController,
        curve: Interval(0.0, 1.0, curve: Curves.easeInCubic)
    ));

    rising = Tween(begin: 120.0, end: 100.0).animate(CurvedAnimation(
        parent: textController,
        curve: Interval(0.0, 1.0, curve: Curves.easeInCubic)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          color: fleshColor,
        ),
        Positioned(
          child: ScaleTransition(
                scale: height,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: new BoxDecoration(
                    color: Colors.blueGrey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ),
        Positioned(
          height: 320,
          width: 320,
          child: CircularProgressIndicator(
            value: delayedAnimation.value,
            strokeWidth: 22,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue),
          ),
        ),
        Positioned(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Builder(
              builder: (context) {
                final handle = GestureDetector(
                  onHorizontalDragCancel: () {
                    showIcons = false;
                    actionPerformed = false;
                    valueListener.value = 0.5;
                    largeCircleController.reverse().orCancel;
                  },
                  onHorizontalDragEnd: (details) {
                    showIcons = false;
                    actionPerformed = false;
                    valueListener.value = 0.5;
                    largeCircleController.reverse().orCancel;
                  },
                  onHorizontalDragStart: (_) {
                    showIcons = true;
                    largeCircleController.forward();
                  },
                  onHorizontalDragUpdate: (details) {
                    valueListener.value = (valueListener.value +
                        details.delta.dx / context.size.width)
                        .clamp(.0, 1.0);

                    //Right, Sending mail
                    if(valueListener.value > 0.9 && !actionPerformed) {
                      responseText = 'Sending Alerts';
                      textController.forward().orCancel;
                      actionPerformed = true;

                        //run task in the isolate
                        final task = Task(runnable: Runnable(fun1:sendMessages()));
                        Executor().addTask(task: task).then((result){
                          print(result);
                        }).catchError((error) {
                          print((error));
                        });

                    }
                    //left, starting video recording
                    else if (valueListener.value < 0.1 && !actionPerformed) {
                      responseText = 'Starting recording';
                      textController.forward().orCancel;
                      actionPerformed = true;
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pushReplacementNamed(context, recordingRoute);
                      });
                    }
                  },
                  onLongPressStart: (_) {
                    print('long press ');
                    circleProgressController.forward();
                    largeCircleController.forward();
                  },
                  onLongPressEnd: (_) {
                    print('long press end');
                    if (circleProgressController.status == AnimationStatus.forward || circleProgressController.status == AnimationStatus.completed) {
                      circleProgressController.reset();
                      largeCircleController.reverse().orCancel;
                    }
                  },
                  child: Container(
                    decoration: new BoxDecoration(
                      color: blueColor,
                      shape: BoxShape.circle,
                    ),
                    height: 100.0,
                    width: 100.0,
                  ),
                );

                return AnimatedBuilder(
                  animation: valueListener,
                  builder: (context, child) {
                    return Align(
                      alignment: Alignment(valueListener.value * 2 - 1, 0),
                      child: child,
                    );
                  },
                  child: handle,
                );
              },
            ),
          ),
        ),
        Positioned(
          left: 60,
          child: Visibility(
            visible: showIcons,
            child: Icon(
              Icons.video_call,
              size: 80,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          right: 60,
          child: Visibility(
            visible: showIcons,
            child: Icon(
              Icons.sms_failed,
              size: 80,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: rising.value,
          child: FadeTransition(
            opacity: opacity,
            child: Container(
              width: MediaQuery.of(context).size.width*0.8,
              child: Column(
                children: <Widget>[
                  Material(
                    type: MaterialType.transparency,
                    child: Text(
                      responseText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 38,
          top: 50,
          child: Material(
            type: MaterialType.transparency,
            child: Opacity(
              opacity: 0.5,
              child: Icon(
                Icons.settings,
                size: 45,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Positioned(
          right: 45,
          top: 45,
          child: Material(
            type: MaterialType.transparency,
            child: IconButton(
              icon: Icon(
                Icons.settings,
                size: 45,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, settingsRoute);
              },
            ),
          ),
        ),
        Positioned(
          left: 54.5,
          top: 49.5,
          child: Material(
            type: MaterialType.transparency,
            child: Opacity(
              opacity: 0.5,
              child: Icon(
                Icons.info_outline,
                size: 45,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Positioned(
          left: 45,
          top: 45,
          child: Material(
            type: MaterialType.transparency,
            child: IconButton(
              icon: Icon(
                Icons.info_outline,
                size: 45,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, knowYourRightRoute);
              },
            ),
          ),
        ),
        Positioned(
          left: 105,
          top: 55,
          child: Material(
            type: MaterialType.transparency,
            child: Text (
              "Know Your\nRights",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                fontFamily: 'Open Sans',
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    largeCircleController.dispose();
    circleProgressController.dispose();
    textController.dispose();
    super.dispose();
  }
}