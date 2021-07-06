import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:context_awareness/logic/alarmservice.dart';
import 'package:context_awareness/logic/pauseservice.dart';
import 'package:context_awareness/logic/rmvservice.dart';
import 'package:context_awareness/provider/ActivityProvider.dart';
import 'package:context_awareness/provider/AlarmProvider.dart';
import 'package:context_awareness/provider/LocationProvider.dart';
import 'package:context_awareness/provider/PauseProvider.dart';
import 'package:context_awareness/provider/RMVProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RMVStatus? _rmvStatus;
  @override
  Widget build(BuildContext context) {
    bool rmvActive = context.watch<RMVProvider>().rmvActive;
    bool alarmActive = context.watch<AlarmProvider>().alarmActive;
    bool pauseActive = context.watch<PauseProvider>().workTimerActive;

    ActivityEvent latestActivity =
        context.watch<ActivityProvider>().latestActivity;
    LocationData? locationData =
        context.watch<LocationProvider>().latestLocationData;

    Future<Widget> switchContext() async {
      if (!rmvActive && !alarmActive && !pauseActive) {
        return Text("No service active!");
      }
      if (locationData == null) {
        return Text("No Location data!");
      }
      // RMVService.getCurrentRMVStatus(locationData, latestActivity);\
      print("RMVACTIVE: " + rmvActive.toString());
      if (rmvActive) {
        print("RMV ABFRAGE");
        _rmvStatus =
            await RMVService.getCurrentRMVStatus(locationData, latestActivity);
        print("RMV STATUS: " + _rmvStatus.toString());
        if (_rmvStatus == RMVStatus.ONSTATION) {
          return Column(
            children: [
              Text("You are on a trainstation and waiting!"),
              Text("Take a look at your connections"),
              MaterialButton(
                onPressed: RMVService.openRMV,
                child: Text("rmv.de",
                    style: TextStyle(
                      color: Colors.white,
                    )),
                color: Colors.blue,
              ),
            ],
          );
        } else {
          return Center(
            child: Text(
                "You are too far away from a train station or you are in motion"),
          );
        }
      }

      bool alarm = alarmActive
          ? AlarmService.getCurrentAlarmStatus(locationData, latestActivity)
          : false;
      if (alarm) {
        print("You should set your alarm!");
        return Column(
          children: [
            Text("You are at Home, it is after 11pm and your status is STILL."),
            Text("You might want to set your alarm for tomorrow!"),
            MaterialButton(
              onPressed: AlarmService.setAlarm,
              child: Text("Set Alarm",
                  style: TextStyle(
                    color: Colors.white,
                  )),
              color: Colors.blue,
            ),
          ],
        );
      }
      bool pause = pauseActive
          ? PauseService.getCurrentPauseStatus(
              locationData, latestActivity, context)
          : false;
      if (pause) {
        return Column(
          children: [
            Text("You have been working for over 2 hours."),
            Text("You should take a break and move!")
          ],
        );
      }
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
      } catch (error) {
        print(error);
        return Text("Unknown", style: GoogleFonts.poppins(fontSize: 14));
      }
    }

    // return SafeArea(
    //   child: Align(
    //     alignment: Alignment(0, -0.9),
    //     child: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(
    //         children: [
    //           Text(
    //             'This is your current status:',
    //             style: GoogleFonts.poppins(fontSize: 14),
    //           ),
    //           switchContext(),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return FutureBuilder<Widget>(
        future: switchContext(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
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
                    snapshot.hasData
                        ? snapshot.requireData
                        : Text("No Service Active"),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
