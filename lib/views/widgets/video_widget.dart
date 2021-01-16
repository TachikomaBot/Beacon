import 'package:flutter/material.dart';

class VideoWidget extends StatelessWidget{

  //variables
  String _fileName;
  String _storeLink;
  String _thumbnail;
  DateTime _created;

  //constructor
  VideoWidget(this._fileName, this._storeLink, this._thumbnail, this._created);

  //getters
  String get fileName{
    return this._fileName;
  }

  String get storeLink{
    return this._storeLink;
  }

  String get thumbnail{
    return this._thumbnail;
  }

  DateTime get created{
    return this._created;
  }


  Widget build(BuildContext context){
    return Card(
      child: Row(
        children:<Widget>[
          Image.network(thumbnail),
          Column(
            children: <Widget>[
              Text(fileName),
              Text(created.toString())
            ]
          )
        ]
      ),
    );
  }
}