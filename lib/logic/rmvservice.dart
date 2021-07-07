import 'dart:convert';

import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
  
enum RMVStatus {OUTSIDE, ONSTATION}

class RMVService {
  

  static final String fileName = 'train_stations';

  static Future<RMVStatus> getCurrentRMVStatus(LocationData locationData, ActivityEvent event) async {

    List<LocationC> locations = await getLocations();

    if(locationData.latitude == null || locationData.longitude == null){
      print("lat or long is null");

    }

    for (LocationC station in locations) {
      if (station.latitude + 0.003 >= locationData.latitude! &&
          station.latitude - 0.003 <= locationData.latitude! &&
          station.longitude + 0.003 >= locationData.longitude! &&
          station.longitude - 0.003 <= locationData.longitude! && event.type.toString().split('.').last == "STILL") {
        print("we think you are on the Trainstation " +
            station.name +
            " and waiting for your train to arrive");
        return RMVStatus.ONSTATION;
      }
    }
    return RMVStatus.OUTSIDE;
    
  }

  static Future<List<LocationC>> getLocations() async {
    List<LocationC> _cachedList = List.empty(growable: true);
    if (_cachedList.isEmpty) {
      Map<dynamic, dynamic> json = await _getJsonFromFile(fileName);
      _cachedList = _jsonToLocations(json);
    }
    return _cachedList;
  }

  static Future<Map<dynamic, dynamic>> _getJsonFromFile(String fileName) async {
    String jsonString =
        await rootBundle.loadString('assets/train_stations/$fileName.json');
    return jsonDecode(jsonString);
  }

  static List<LocationC> _jsonToLocations(Map<dynamic, dynamic> json) {
    List<LocationC> locations = [];
    for (var element in json["elements"]) {
      locations.add(LocationC.fromJson(element));
    }
    return locations;
  }

  static void openRMV() async => await canLaunch('https://www.rmv.de/c/de/start/ring') ? await launch('https://www.rmv.de/c/de/start/ring') : throw 'Could not launch rmv.de';
}

class LocationC {
  final double longitude;
  final double latitude;
  final String name;
  LocationC({
    required this.longitude,
    required this.latitude,
    required this.name,
  });
  LocationC.fromJson(Map<dynamic, dynamic> json)
      : longitude = json['lon'],
        latitude = json['lat'],
        name = json['tags']['name'];
}
