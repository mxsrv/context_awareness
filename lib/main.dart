rimport 'dart:io';

import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:context_awareness/widgets/drawer.dart';
//import 'package:context_awareness/widgets/home.dart';

void main() => runApp(AwareMe());

class AwareMe extends StatefulWidget {
  @override
  _AwareMeState createState() => new _AwareMeState();
}

class _AwareMeState extends State<AwareMe> {
  late Stream<ActivityEvent> activityStream;
  ActivityEvent latestActivity = ActivityEvent.empty();
  List<ActivityEvent> _events = [];
  ActivityRecognition activityRecognition = ActivityRecognition.instance;

  Text switchContext() {
    try {
      switch (_events[_events.length-1].type.toString().split('.').last) {
        case "STILL":
          return Text("You are sitting",
              style: GoogleFonts.poppins(fontSize: 14));
        case "ON_BICYCLE":
          return Text("You are on a bicycle",
              style: GoogleFonts.poppins(fontSize: 14));
        case "ON_FOOT":
          return Text("You are on foot",
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
    _init();
  }

  void _init() async {
    /// Android requires explicitly asking permission
    if (Platform.isAndroid) {
      if (await Permission.activityRecognition.request().isGranted) {
        _startTracking();
      }
    }

    /// iOS does not
    else {
      _startTracking();
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'aware.me',
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF164A5C),
            automaticallyImplyLeading: true,
            title: Text(
              'aware.me',
              style: GoogleFonts.poppins(fontSize: 26),
            ),
            centerTitle: true,
          ),
          drawer: AppDrawer(),
          body: SafeArea(
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
                                leading: Text(entry.timeStamp
                                    .toString()
                                    .substring(0, 19)),
                                trailing: Text(
                                    entry.type.toString().split('.').last));
                          }),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
