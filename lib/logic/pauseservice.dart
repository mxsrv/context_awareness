import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:context_awareness/provider/PauseProvider.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class PauseService {
  static bool needsBreak = false;
  // if still && atHome && time > 23:00 -> remind user to set alarm
  static bool getCurrentPauseStatus(
      LocationData locationData, ActivityEvent event, BuildContext context) {
    int worktime = context.watch<PauseProvider>().workTime;
    DateTime date = DateTime.now();
    // if(date.hour > 7 && date.hour < 18){
    if (date.hour > 7 && date.hour < 24) {
      print("you are probably working right now");
      if (locationData.latitude == null || locationData.longitude == null) {
        print("lat or long is null");
      }
      if ((locationData.latitude! * 1000).truncate() / 1000 == 49.845 &&
          (locationData.longitude! * 1000).truncate() / 1000 == 8.645) {
        print("You are at home or in the office");
        if (event.type.toString().split('.').last == "STILL") {
          print("You are probably working");
          print(worktime / 1000 / 60 / 60);
          if (worktime == 0) {
            context.read<PauseProvider>().startStopwatch();
          } else if (worktime / 1000 / 60 > 2) {
            // } else if (worktime / 1000 / 60 / 60 > 2) {
            // consider taking a break
            needsBreak = true;
            return true;
          }
        }
      }
      if (event.type.toString().split('.').last == "ON_FOOT" ||
          event.type.toString().split('.').last == "ON_BICYCLE") {
        needsBreak = false;
        context.read<PauseProvider>().resetStopwatch();
      }
    }
    return false;
  }
}
