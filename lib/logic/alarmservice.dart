import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:location/location.dart';
import 'package:device_apps/device_apps.dart';
import 'package:url_launcher/url_launcher.dart';


class AlarmService {
  // if still && atHome && time > 23:00 -> remind user to set alarm
 static bool getCurrentAlarmStatus(LocationData locationData, ActivityEvent event){
    DateTime date = DateTime.now();
    // if(date.hour < 5 || date.hour > 22){
    if(date.hour < 5 || date.hour > 14){
      print("you are probably going to bed soon.");
      if(locationData.latitude == null || locationData.longitude == null){
        print("lat or long is null");
      }
      if((locationData.latitude! * 1000).truncate() / 1000 == 49.845 && (locationData.longitude! * 1000).truncate() / 1000 == 8.645){
        print("You are at home");
        if(event.type.toString().split('.').last == "STILL"){
          //get user to set alarm
          return true;
        }
      }
    }
    return false;
 } 

 static void setAlarm() {
  DeviceApps.openApp('com.google.android.deskclock');
 }
  
}