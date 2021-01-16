import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShowVideo extends StatefulWidget{
  ShowVideoState createState() => ShowVideoState();

  //get data passed from index
  final String data;

  //constructor
  ShowVideo({Key key, @required this.data}): super(key: key);
}

class ShowVideoState extends State<ShowVideo>{

  //this controller will be used to play videos
  VideoPlayerController _controller;

  @override
  void initState(){
    super.initState();

    //initialize controller with a video passed from IndexVideos
    _controller = VideoPlayerController.network(widget.data)..initialize().then((_) {
      setState((){}); //change state to display video
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        //if controller is initialized show video else show empty container
        child: _controller.value.initialized ? AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller)) : Container(),

        //add play and indicator widgets
      )
    );
  }

  void dispose(){
    super.dispose();
    _controller.dispose();
  }
}