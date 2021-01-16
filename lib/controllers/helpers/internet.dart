import 'package:connectivity/connectivity.dart';

/*
  This checks if there is an internet connection or not.
  Note this just fires once when called. 
  It doesn't continually listen for change in internet connection
*/
Future<bool> hasInternet() async{
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    return true;
  }

  return false;
}