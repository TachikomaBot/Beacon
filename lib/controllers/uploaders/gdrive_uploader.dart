import 'package:Beacon/controllers/helpers/auth.dart';
import 'package:Beacon/controllers/helpers/notifications.dart';
import 'package:Beacon/models/transmitable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'file_uploader.dart';
import 'dart:convert';
import "package:http/http.dart" as http;

class GDriveUploader extends FileUploader{

  //singleton
  static final GDriveUploader _singleton = new GDriveUploader._internal();

  factory GDriveUploader(){
    return _singleton;
  }

  GDriveUploader._internal();

  /*
    The following function has two purpose
    1. create a 'Beacon' super folder (will be called once, on user sign in)
    2. create subfolder of 'Beacon'
  */
  handleUploadFolder(String folderName) async {

    //get folderID from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setFolderID(prefs.getString('folderID'));

    //if folderID doesnt exists this method will be used for creating a 'Beacon' super folder
    final parents = (folderID == null) ? ['root'] : [folderID]; 
    var headers = await generateHeader();
    
    Uri uri = Uri.parse('https://www.googleapis.com/drive/v3/files');

    //create request
    final request = http.Request('POST', uri)
      ..headers.addAll({
        'Authorization': headers['Authorization'],
        'Content-Type': 'application/json',
    });
    
     String body = json.encode({
      'name' : folderName,
      'parents' : parents,
      'mimeType' : 'application/vnd.google-apps.folder',
    });

    request.body = body;

    //send request for response
    http.StreamedResponse response = await request.send();

    //print response
    response.stream.transform(utf8.decoder).listen((value) {
      var requestJson = json.decode(value);
      final newfolderID = requestJson['id'];

      //set folderID to FolderUploader
      setFolderID(newfolderID); 

      //store folderID to Shared Preference too for data persistence between app runs
      prefs.setString('folderID', newfolderID);

      print('folderID: $folderID');
    });
  }

  /*
    This initializes the resumable file upload. 
    This returns the new initialized Transmitable after it has been processed successfully
    else returns the same Transmitable.
  */
  // Future<bool> initUploadData(String filename, String path, String folderID) async{
  Future<Transmitable> initUploadData(Transmitable data) async{
    //declare variables for later use
    var headers = await generateHeader();

    Uri uri = Uri.parse('https://www.googleapis.com/upload/drive/v3/files?uploadType=resumable');
    
    //get folderID from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setFolderID(prefs.getString('folderID'));
    var parents = [folderID];

    var body = json.encode({
      'name' : data.videoFile.fileName,
      'parents' : parents,
    });
    
    //create post request
    final initialStreamedRequest =
      new http.StreamedRequest('POST', uri)
        ..headers.addAll({
        'Authorization': headers['Authorization'],
        'Content-Length' : utf8.encode(body).length.toString(),
        'Content-Type' : 'application/json; charset=UTF-8',
        'X-Upload-Content-Type' : 'video/mp4',
        'X-Upload-Content-Length' : data.videoFile.fileLength
      });

    initialStreamedRequest.sink.add(utf8.encode(body));
    initialStreamedRequest.sink.close();

    //send post request
    http.StreamedResponse response = await initialStreamedRequest.send();

    //process response

    //successfully initialized
    print(response.statusCode);
    if (response.statusCode == 200) {
      data.setSessionURI(Uri.parse(response.headers['location']));
      data.setInitialized(true);

      print('sessionURI '+ data.sessionURI.toString());
      return data;
    
    //unsuccessful
    } else{
      print('resumable upload not initialized');
      return data;
    }
  }

  /*
    This sends a subsequent request after resumable upload initialized.
    The response corresponds to the following...

    > 200 OK or 201 Created - response indicates that the upload was completed, and no further action is necessary.
    > 308 Resume Incomplete - response indicates that you need to continue to upload the file.
    > 404 Not Found - response indicates the upload session has expired and the upload needs to be restarted from the start.

    This will return the updated Transmitable based on the responses above.
  */
  Future<Transmitable> resumeUploadData(Transmitable data) async{

    //create a put request
    final fileStreamedRequest =
    new http.StreamedRequest('PUT', data.sessionURI)
      ..headers.addAll({
        'Content-Length' : data.videoFile.fileLength,
        'Content-Type' : 'video/mp4',
      });
    fileStreamedRequest.sink.add(data.videoFile.file.readAsBytesSync());
    fileStreamedRequest.sink.close();

    //send put request
    http.StreamedResponse response = await fileStreamedRequest.send();
    
    //process response
    print(response.statusCode);
    if(response.statusCode == 200 || response.statusCode == 201){
      data.setTransmitted(true);
      data.setDeparted(DateTime.now());

      //status report
      showVideoNotification();
     
    } else if(response.statusCode == 308){
      data.setTransmitted(false);
  
      //status report
    
    } else if(response.statusCode == 404){
      data.setTransmitted(false);
      data.setInitialized(false);

      //status report
    }

    //return response that will be processed by caller
    return data;
  }
}