import 'dart:async';
import 'package:Beacon/controllers/auth/google_auth.dart';
import 'package:Beacon/controllers/callers/contact.dart';
import 'package:Beacon/controllers/helpers/detect_os.dart';
import 'package:Beacon/router.dart';
import 'package:Beacon/views/screens/control_center.dart';
import 'package:Beacon/views/screens/login.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:worker_manager/executor.dart';
import 'controllers/helpers/error.dart';
import 'controllers/listeners/transmit_listener.dart';
import 'controllers/uploaders/gdrive_uploader.dart';

// Declare variable for camera fetching
List<CameraDescription> cameras;
StreamSubscription transmitSub;

Future<void> main() async {

  //config .env for testing credentials
  await DotEnv().load('.env');

  //init isolate executor for running functions on another thread
  await Executor().warmUp();

  //fetch all available cameras of device
  try{
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras(); 
  } on CameraException catch (e){
    logError(e.code, e.description);
  }

  //setup TransmitListener
  final transmitListener = TransmitListener();
  transmitSub = transmitListener.setUpListener();

  //pause/resume TransmitListener if there is internet or not
  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        transmitSub.resume();
      } else{
        transmitSub.pause();
      }
  });

  //run the app
  runApp(BeaconApp());
}

class BeaconApp extends StatefulWidget{
  @override
  BeaconAppState createState() => BeaconAppState();
}

class BeaconAppState extends State<BeaconApp>{
  
  // Declare variables for later use
  StreamSubscription _sub;
  bool user = false;

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  @override
  void dispose(){
    if(_sub != null) _sub.cancel();
    super.dispose();
  }

  /*
    This initializes listener for uni links after checking if device is < iOS 11.
    This is coverage for flutter_web_auth's limitation on lower versions of iOS

    ALSO, it checks if an auth token already exists and sets 'user' to true right away
    
    DEV NOTE: The following code cannot be exported to other files since 
              subscription variable has to be available here so it can be 
              disposed.
  */
  _initPlatformState() async{
    
    //silent sign in if token exists
    await _silentSignIn();

    //setup listener
    if(await detectLowIOS()) _setupListener();
  }

  /*
    This setups the listener for uni links
  */
  _setupListener() {
    _sub  = getLinksStream().listen((String result) async {
      if(!mounted) return;
      
      //determine what Auth user chose then
      final auth = GoogleAuth();

      //process callback result
      await auth.parseResultHandler(result);

      //if auth token exists then user exists
      if(await auth.getToken() != null){
        setState(() { 
          user = true; 
        });
      }

    });
  }

  /*
    This is silently signs in the user if token exists
  */
  _silentSignIn() async{

    //determine what Auth user chose then
    final auth = GoogleAuth();

    //if auth token exists then user exists
    String token;
    try{
      token = await auth.getToken();
    
    }on WrongAuthTypeError{
      print(new WrongAuthTypeError());
    
    }on NoResponseError{
      print(new NoResponseError());
    
    }on BadResponseError{
      print(new BadResponseError());
    
    }on FileDNEError{
      print(new FileDNEError());
    }

    //user exists
    if(token != null){
      setState(() { 
        user = true; 
      });
    }

    //set FolderId
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GDriveUploader().setFolderID(prefs.getString('folderID'));

    //setup ContactManager
    setupContactManager();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      home: user ? ControlCenterScreen() : LoginScreen()
    );
  }
}