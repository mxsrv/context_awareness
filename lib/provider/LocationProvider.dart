import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  Location _location = new Location();
  LocationData? _locationData;

  Future<LocationData> get latestLocation async => await _location.getLocation();
  LocationData? get latestLocationData => _locationData;

  void startLocationService() async {
    if (!await _location.serviceEnabled()) {
      bool service = await _location.requestService();
      if(!service){
        print("permissions for location service not granted.");
        return;
      }
    }

    if (await _location.hasPermission() == PermissionStatus.denied) {
      PermissionStatus permission = await _location.requestPermission();
      if(permission != PermissionStatus.granted){
        print("permissions for location not granted.");
        return;
      }
    }
    _location.onLocationChanged.listen(onData);
  }

  void onData(LocationData loc) {
    print(loc);
    _locationData = loc;
    notifyListeners();
  }
}