import 'package:geolocator/geolocator.dart';

class Geolocation {

  //declare private variables for later use
  double _latitude = 0;
  double _longitude = 0;
  
  //singleton
  static final Geolocation _singleton = new Geolocation._internal();

  factory Geolocation(){
    return _singleton;
  }

  Geolocation._internal();

  //getter and setter
  double get latitude{
    return _latitude;
  }

  double get longitude{
    return _longitude;
  }

  setLatitude(double latitude){
    this._latitude = latitude;
  }

  setLongitude(double longitude){
    this._longitude = longitude;
  }

  /*
    This updates the private variables in Geolocation Class and more importantly retrieves the last know coordinates of the device
  */
  Future<Position> getLastKnownCoords() async {
    bool _locationFound = false;
    String result = "Unknown";

    Future<Position> lastKnownPos = Geolocator().getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.high
    );

    lastKnownPos.then((val) {
      _latitude = val.latitude;
      _longitude = val.longitude;
      _locationFound = true;
    });

    if (_locationFound) {
      result = "Latitude: " + _latitude.toString() + " | Longitude: " + _longitude.toString();
      print(result);
    }

    return lastKnownPos;
  }
}

