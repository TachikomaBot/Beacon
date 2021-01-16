import 'package:Beacon/controllers/helpers/auth.dart';
import 'package:Beacon/controllers/uploaders/gdrive_uploader.dart';
import 'package:Beacon/models/video_file.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

class VideoManager{
  
  //declare variables for later use
  List<VideoFile> _videos;

  //singleton
  static final VideoManager _singleton = new VideoManager._internal();

  factory VideoManager(){
    return _singleton;
  }

  VideoManager._internal();

  //getter
  List<VideoFile> get videos{
    return this._videos;
  }

  /*
    This fetches all the videos in the user's cloud storage
  */
  fetchVideos() async{
    
    //http request to get all videos on google drive
    var headers = await generateHeader();

    Uri uri = Uri.parse('https://www.googleapis.com/drive/v3/files');

    http.Request request = http.Request('GET', uri)
      ..headers.addAll({
        "Authorization": headers['Authorization'],
        "q": "'${GDriveUploader().folderID}' in parents"
    });

    http.StreamedResponse response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) {
      var result = json.decode(value);
      final videoList = result["files"];

      videoList.forEach((video) async{
        videos.add(await _getMetaData(video['id']));
      });

    });
  }

  /*
    This returns the metadata of a given video in Google Drive
  */
  Future<VideoFile> _getMetaData(String videoID) async{

    VideoFile videoFile;
    
    //http request to get all videos on google drive
    var headers = await generateHeader();

    Uri uri = Uri.parse('GET https://www.googleapis.com/drive/v3/files/$videoID');

    http.Request request = http.Request('GET', uri)
      ..headers.addAll({
        "Authorization": headers['Authorization'],
        "fields": "*"
    });

    http.StreamedResponse response = await request.send();
  
    response.stream.transform(utf8.decoder).listen((value){
      var result = json.decode(value);

      //get data from result
      final thumbnail = result['thumbnailLink'];
      final storeLink = result['webViewLink'];
      final created = result['createdTime'];

      //set data
      videoFile.setThumbnail(thumbnail);
      videoFile.setStoreLink(storeLink); 
      videoFile.setCreated(created);

    });

    return videoFile;
  }
}