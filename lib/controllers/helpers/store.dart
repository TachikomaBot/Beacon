import 'dart:io';
import 'package:path_provider/path_provider.dart';

/*======================================================
  The following is used to to store local file in oAuth
========================================================*/

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> localFile(String filename) async {
  final path = await _localPath;
  return File('$path/$filename');
}