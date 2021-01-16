import 'package:Beacon/models/video_file.dart';

class Transmitable{

  //constructor
  Transmitable([VideoFile videoFile]){
    this._videoFile = videoFile;
    this._arrived = DateTime.now();
  }

  //complete constructor
  Transmitable.complete(
    this._transmitted,
    this._initialized,
    this._arrived,
    this._departed,
    this._logTime,
    this._sessionURI,
    this._videoFile
  );

  //for parsing from json
  factory Transmitable.fromJson(dynamic json){
    return Transmitable.complete(
      json['transmitted'] as bool,
      json['initialized'] as bool,
      json['arrived'] as DateTime,
      json['departed'] as DateTime,
      json['logTime'] as DateTime,
      json['sessionURI'] as Uri,
       VideoFile.fromJson(json['videoFile']),
    );
  }
  
  //declare values for later use

  bool _transmitted = false; //success status
  bool _initialized = false; //if true use resumeUploadData else initUploadData
  
  DateTime _arrived; // when the transmitable was created/first arrived to the TransmitManager
  DateTime _departed; // when the transmitable was transmitted successfully departed from the TransmitManager

  DateTime _logTime; // this records the current attempt time of Transmitable

  Uri _sessionURI;

  VideoFile _videoFile;

  //getters and setters
  bool get transmitted{
    return this._transmitted;
  }

  setTransmitted(bool transmitted){
    this._transmitted = transmitted;
  }

  bool get initialized{
    return this._initialized;
  }

  setInitialized(bool initialized){
    this._initialized = initialized;
  }

  DateTime get arrived{
    return this._arrived;
  }

  setArrived(DateTime arrived){
    this._arrived = arrived;
  }

  DateTime get departed{
    return this._departed;
  }

  setDeparted(DateTime departed){
    this._departed = departed;
  }

  DateTime get logTime{
    return this._logTime;
  }

  setLogTime(DateTime logTime){
    this._logTime = logTime;
  }

  Uri get sessionURI{
    return this._sessionURI;
  }

  setSessionURI(Uri sessionURI){
    this._sessionURI = sessionURI;
  }

  VideoFile get videoFile{
    return this._videoFile;
  }

  /*
    This allows this object to be converted into a json via jsonEncode
  */
  Map toJson() {
    Map videoFile = (this._videoFile != null) ? this.videoFile.toJson() : null;
    
    return{
      'transmitted': transmitted,
      'initialized': initialized,
      'arrived': arrived,
      'departed': departed,
      'logTime': logTime,
      'sessionURI': sessionURI,
      'videoFile': videoFile
    };

  }
}