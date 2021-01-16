import 'package:Beacon/views/screens/contacts_screen/index.dart';
import 'package:Beacon/views/screens/contacts_screen/show.dart';
import 'package:Beacon/views/screens/know_your_rights_screen.dart';
import 'package:flutter/material.dart';
import 'package:Beacon/views/screens/control_center.dart';
import 'package:Beacon/views/screens/login.dart';
import 'package:Beacon/controllers/recorders/video_recorder.dart';
import 'package:Beacon/views/screens/settings.dart';

//define router names
const signInRoute = '/';
const controlCenterRoute = '/control_center';
const settingsRoute = '/settings';
const recordingRoute = '/recording';
const contactsRoute = '/contacts';
const contactEditRoute = '/contact_edit';
const knowYourRightRoute = '/know_your_rights-';

//this generates defined routes
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      //LOGIN
      case signInRoute:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(),
            settings: RouteSettings(name: signInRoute)
        );

      //CONTROL CENTER
      case controlCenterRoute:
        return MaterialPageRoute(
            builder: (_) => ControlCenterScreen(),
            settings: RouteSettings(name: controlCenterRoute)
        );

      //SETTINGS
      case settingsRoute:
        return MaterialPageRoute(
            builder: (_) => SettingScreen(),
            settings: RouteSettings(name: settingsRoute)
        );

      //VIDEO RECORDING
      case recordingRoute:
        return MaterialPageRoute(
            builder: (_) => VideoRecorder(),
            settings: RouteSettings(name: recordingRoute)
        );

      //ALL CONTACTS
      case contactsRoute:
        return MaterialPageRoute(
            builder: (_) => ContactsIndex(),
            settings: RouteSettings(name: contactsRoute)
        );

      //CREATE/EDIT CONTACT
      case contactEditRoute:
        return MaterialPageRoute(
            builder: (_) => ContactShow(),
            settings: RouteSettings(name: contactEditRoute)
        );

      //RIGHTS INFO
      case knowYourRightRoute:
        return MaterialPageRoute(
            builder: (_) => KnowYourRightsScreen(),
            settings: RouteSettings(name: knowYourRightRoute)
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(child: Text('ERROR 404')),
      );
    });
  }
}