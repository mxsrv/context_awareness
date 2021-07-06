import 'package:flutter/material.dart';
import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class ActivityProvider with ChangeNotifier {
  ActivityEvent _latestActivity = ActivityEvent.empty();
  late Stream<ActivityEvent> activityStream;
  ActivityRecognition activityRecognition = ActivityRecognition.instance;

  ActivityEvent get latestActivity => _latestActivity;

  void startTracking() async {
    if (await Permission.activityRecognition.request().isGranted) {
    activityStream =
        activityRecognition.startStream(runForegroundService: true);
    activityStream.listen(onData);
    } else {
      print("Permission have not been given");
    }
  }

  void onData(ActivityEvent activityEvent) {
    print(activityEvent.toString());
    _latestActivity = activityEvent;
    notifyListeners();
  }
}