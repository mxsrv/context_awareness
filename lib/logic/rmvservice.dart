import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:location/location.dart';

class RMVService {
  static void getCurrentRMVStatus(LocationData locationData, ActivityEvent event) {
    if(locationData.latitude == null || locationData.longitude == null){
      print("lat or long is null");
    }
    if((locationData.latitude! * 1000).truncate() / 1000 == 49.845 && (locationData.longitude! * 1000).truncate() / 1000 == 8.645){
      print("You are at home");
      if(event.type.toString().split('.').last == "STILL"){
        print("get up and do something you fatfuck");
      }
    }
  }
}
