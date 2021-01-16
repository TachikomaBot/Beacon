
import 'package:Beacon/controllers/helpers/hexcolor.dart';
import 'package:Beacon/router.dart';
import 'package:Beacon/views/screens/videos_screen/index.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget{
  @override
  SettingScreenState createState() => SettingScreenState();
}

/*
  This is the settings screen that user can interact with
*/
class SettingScreenState extends State<SettingScreen>{
  @override
  void initState() {
    super.initState();
  }

  /*
    This is the list of setting options
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fleshColor,
        title: Text('Settings'),
      ),
      backgroundColor: fleshColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                color: Colors.white70,
                onPressed: () {
                  Navigator.pushNamed(context, contactsRoute);
                },
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.person_outline,
                      size: 50,
                    ),
                    Text(
                      'Contacts',
                      style: TextStyle(
                        fontSize: 30
                      ),
                    )
                  ],
                )
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                color: Colors.white70,
                onPressed: () {
                },
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.cloud_off,
                      size: 50,
                    ),
                    Text(
                      'Disconnect\nAccount',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                      ),
                    )
                  ],
                )
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                  color: Colors.white70,
                  onPressed: () {
                    //FileUploader().handleUploadFolder('BeaconTest', true);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => IndexVideos()));
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.info_outline,
                        size: 50,
                      ),
                      Text(
                        'About\nBeacon',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      )
                    ],
                  )
              ),
            ],
          ),
        ],
      )
    );
  }
}