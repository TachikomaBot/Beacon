import 'package:Beacon/controllers/managers/video_manager.dart';
import 'package:Beacon/models/video_file.dart';
import 'package:Beacon/views/screens/videos_screen/show.dart';
import 'package:flutter/material.dart';
import 'package:Beacon/views/widgets/video_widget.dart';

class IndexVideos extends StatefulWidget{
  IndexVideosState createState() => IndexVideosState();
}

class IndexVideosState extends State<IndexVideos>{
  @override
  void initState(){
    super.initState();
  }
  
  //call on VideoManager's methods
  Future<List<VideoFile>> _fetchRecordings() async{
    final manager = VideoManager();
    await manager.fetchVideos();
    return manager.videos;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: FutureBuilder(
        future: _fetchRecordings(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.data != null){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) =>
                InkWell(
                  child: VideoWidget(
                    snapshot.data[index].fileName,
                    snapshot.data[index].storeLink,
                    snapshot.data[index].thumbnail,
                    snapshot.data[index].created
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowVideo(data: snapshot.data[index].storeLink)));
                  },
                )
            );
          } else{
            return CircularProgressIndicator();
          }
        }
      ),
    );
  }
}