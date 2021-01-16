
/*
  This is the listener for the TransmitManager (a stream).
  This will be called on the states of ControlCenterScreen.
*/
import 'dart:async';
import 'package:Beacon/controllers/managers/transmit_manager.dart';
import 'package:Beacon/controllers/uploaders/gdrive_uploader.dart';
import 'package:Beacon/models/transmitable.dart';

class TransmitListener{

  //singleton
  static final TransmitListener _singleton =  new TransmitListener._internal();

  factory TransmitListener(){
    return _singleton;
  }

  TransmitListener._internal();

  //declare stream to listen to
  final myStream = TransmitManager().stream;

  StreamSubscription _subscription;

  StreamSubscription get subscription{
    return this._subscription;
  }

  //method --> set up listener
  StreamSubscription setUpListener(){
    final subscription = myStream.listen(
      (data) {
        _processData(data);
      }, onError: (err) {
        print('Listen Error occured');
      },
    );

    return subscription;
  }

  //this process the data from listener
  _processData(Transmitable data) async{
    if(!data.initialized){
      //initialize the upload of data
      Transmitable initData = await GDriveUploader().initUploadData(data); //fixed only for GDrive right now
      TransmitManager().add(initData); //add back to TransmitManager

    } else{
      //resume the upload of data
      Transmitable resumeData = await GDriveUploader().resumeUploadData(data);

      // if data is not transmitted fully add back to Transmit Manager
      if(!resumeData.transmitted) TransmitManager().add(resumeData);
    }
  }
}