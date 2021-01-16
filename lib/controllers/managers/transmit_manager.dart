import 'dart:async';
import 'package:Beacon/models/transmitable.dart';

class TransmitManager{

  //this is records all the tasks/transmitables added to the stream
  List<Transmitable> _tasks = [];

  //singleton
  static final TransmitManager _singleton = new TransmitManager._internal();

  factory TransmitManager(){
    return _singleton;
  }

  TransmitManager._internal();

  //getter
  List<Transmitable> get tasks{
    return this._tasks;
  }

  // this controls what is added/removed in the stream
  final _controller = StreamController<Transmitable>();

  // this ADDS Transmitables to the stream
  add(Transmitable transmitable){
    _controller.sink.add(transmitable);
    addTask(transmitable);
  }

  /* 
    This is the Stream where a listener will listen.
    Once the listener listens and receives the Transmitable it will
    attempt to upload it.
  */
  Stream<Transmitable> get stream => _controller.stream;

  /*
    This gets a particular task in tasks
  */
  Transmitable getTask(Transmitable _task){
    return tasks.firstWhere((task) => task.sessionURI == _task.sessionURI);
  }

  /*
    This removes a particular task in tasks
  */
  popTask(Transmitable _task){
    Transmitable result = getTask(_task);
    tasks.remove(result);
  }

  /*
    This adds a particular task in tasks
  */
  addTask(Transmitable _task){
    tasks.add(_task);
  }
}