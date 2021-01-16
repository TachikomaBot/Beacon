import 'package:Beacon/controllers/callers/login.dart';
import 'package:Beacon/controllers/helpers/hexcolor.dart';
import 'package:Beacon/router.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

// Declare variables for camera fetching
List<CameraDescription> cameras;

class LoginScreen extends StatefulWidget{
  @override
  LoginScreenState createState() => LoginScreenState();
}

/*
  This is the login screen
*/
class LoginScreenState extends State<LoginScreen>{
  bool showProgressIndicator = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: fleshColor,
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //this is the login logo image
              Image.asset('assets/login_logo.png', width: 300, height: 300),

              //this is contains the login auth buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Visibility(
                        visible: !showProgressIndicator,
                        child: GoogleSignInButton(
                          onPressed: () {
                            onActiveSignIn().then((result) {
                              if (result) {
                                setState(() {
                                  showProgressIndicator = result;
                                });
                                Future.delayed(Duration(seconds: 6)).then((_) {
                                  Navigator.pushReplacementNamed(context, controlCenterRoute);
                                });
                              }
                            });
                          },
                          darkMode: true,
                        ),
                      ),
                      Visibility(
                        visible: showProgressIndicator,
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          backgroundColor: Colors.blueGrey,

                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}