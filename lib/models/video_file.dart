import 'dart:io';

class VideoFile{

  //declare variables
  String _folderID = '';
  File _file;
  String _fileLength;
  String _fileName;
  String _thumbnail;
  String _storeLink;
  DateTime _created;

  //constructor
  VideoFile();

  //complete constructor
  VideoFile.complete(
    this._folderID,
    this._file,
    this._fileLength,
    this._fileName,
    this._thumbnail,
    this._storeLink,
    this._created
  );

  //for parsing from json
  factory VideoFile.fromJson(dynamic json){
    return VideoFile.complete(
      json['folderID'] as String,
      json['file'] as File,
      json['fileLength'] as String,
      json['fileName'] as String,
      json['thumbnail'] as String,
      json['storeLink'] as String,
      json['created'] as DateTime
    );
  }

  //getter and setter
  String get folderID{
    return _folderID;
  }

  setFolderID(String folderID){
    this._folderID = folderID;
  }

  File get file{
    return _file;
  }

  setFile(File file){
    this._file = file;
  }

  String get fileLength{
    return this._fileLength;
  }

  setFileLength(String fileLength){
    this._fileLength = fileLength;
  }

  String get fileName{
    return this._fileName;
  }

  setFileName(String fileName){
    this._fileName = fileName;
  }

  String get thumbnail{
    return this._thumbnail;
  }

  setThumbnail(String thumbnail){
    this._thumbnail = thumbnail;
  }

  String get storeLink{
    return this._storeLink;
  }

  setStoreLink(String storeLink){
    this._storeLink = storeLink;
  }

  DateTime get created{
    return this._created;
  }

  setCreated(DateTime created){
    this._created = created;
  }

  /*
    This returns the json form of this object
  */
  Map toJson() => {
    'folderID': folderID,
    'file': file,
    'fileLength': fileLength,
    'fileName': fileName
  };
}