import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter/material.dart';

class ActivityTracker {
  final Function() notifyParent;
  ActivityTracker({Key? key, required this.notifyParent});
  ActivityEvent latestActivity = ActivityEvent.empty();
  late Stream<ActivityEvent> activityStream;
  ActivityRecognition activityRecognition = ActivityRecognition.instance;

  void startTracking() {
    activityStream =
        activityRecognition.startStream(runForegroundService: true);
    activityStream.listen(onData);
  }

  void onData(ActivityEvent activityEvent) {
    print(activityEvent.toString());
    latestActivity = activityEvent;
    notifyParent();
  }
}
