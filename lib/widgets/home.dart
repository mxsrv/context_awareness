import 'dart:io';

import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:context_awareness/logic/activityTracker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<ActivityEvent> activityStream;
  ActivityEvent latestActivity = ActivityEvent.empty();
  List<ActivityEvent> _events = [];
  ActivityRecognition activityRecognition = ActivityRecognition.instance;
  late ActivityTracker tracker;

  refresh() {
    setState(() {
      latestActivity = tracker.latestActivity;
    });
  }

  Text switchContext() {
    try {
      switch (latestActivity.type.toString().split('.').last) {
        case "STILL":
          return Text("You are sitting",
              style: GoogleFonts.poppins(fontSize: 14));
        case "ON_BICYCLE":
          return Text("You are on a bicycle",
              style: GoogleFonts.poppins(fontSize: 14));
        case "ON_FOOT":
          return Text("You are walking",
              style: GoogleFonts.poppins(fontSize: 14));
        default:
          return Text("Unknown", style: GoogleFonts.poppins(fontSize: 14));
      }
    } on Exception catch (_) {
      return Text("Unknown", style: GoogleFonts.poppins(fontSize: 14));
    } catch (error) {
      return Text("Unknown", style: GoogleFonts.poppins(fontSize: 14));
    }
  }

  @override
  void initState() {
    super.initState();
    super.initState();
    _init();
  }

  void _init() async {
    /// Android requires explicitly asking permission
    if (Platform.isAndroid) {
      if (await Permission.activityRecognition.request().isGranted) {
        tracker = ActivityTracker(notifyParent: refresh);
        tracker.startTracking();
      }
    }

    /// iOS does not
    else {
      tracker = ActivityTracker(notifyParent: refresh);
      tracker.startTracking();
    }
  }
  /*
  void _startTracking() {
    activityStream =
        activityRecognition.startStream(runForegroundService: true);
    activityStream.listen(onData);
  }

  void onData(ActivityEvent activityEvent) {
    print(activityEvent.toString());
    setState(() {
      _events.add(activityEvent);
      latestActivity = activityEvent;
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment(0, -0.9),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'This is your current status:',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              switchContext(),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _events.length,
                    reverse: true,
                    itemBuilder: (BuildContext context, int idx) {
                      final entry = _events[idx];
                      return ListTile(
                          leading:
                              Text(entry.timeStamp.toString().substring(0, 19)),
                          trailing:
                              Text(entry.type.toString().split('.').last));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
