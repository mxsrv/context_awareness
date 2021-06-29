import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';

class ActivityTracker {
  static ActivityEvent latestActivity = ActivityEvent.empty();
  static late Stream<ActivityEvent> activityStream;
  static ActivityRecognition activityRecognition = ActivityRecognition.instance;

  static void startTracking() {
    activityStream =
        activityRecognition.startStream(runForegroundService: true);
    activityStream.listen(onData);
  }

  static void onData(ActivityEvent activityEvent) {
    print(activityEvent.toString());
    latestActivity = activityEvent;
  }
}
