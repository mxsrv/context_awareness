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

    Widget buildAlarmWidget() {
      if (!alarmActive) {
        return Text("Not active!");
      }
      if (locationData == null) {
        return Text("No Location data!");
      }
      bool alarm = alarmActive
          ? AlarmService.getCurrentAlarmStatus(locationData, latestActivity)
          : false;
      if (alarm) {
        print("You should set your alarm!");
        return Column(
          children: [
            Text("You are at Home, it is after 11pm and your status is STILL.",
                style: GoogleFonts.poppins(fontSize: 12)),
            Text("You might want to set your alarm for tomorrow!",
                style: GoogleFonts.poppins(fontSize: 12)),
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
      } else {
        return Text("Active.", style: GoogleFonts.poppins(fontSize: 13));
      }
    }

    Widget buildPauseWidget() {
      if (!pauseActive) {
        return Text("Not active!", style: GoogleFonts.poppins(fontSize: 13));
      }
      if (locationData == null) {
        return Text("No Location data!",
            style: GoogleFonts.poppins(fontSize: 13));
      }
      bool pause = pauseActive
          ? PauseService.getCurrentPauseStatus(
              locationData, latestActivity, context)
          : false;
      if (pause) {
        return Column(
          children: [
            Text("You have been working for over 2 hours.",
                style: GoogleFonts.poppins(fontSize: 13)),
            Text(
                "(" +
                    ((context.watch<PauseProvider>().workTime / 1000 / 60 * 10)
                                .truncate() /
                            10)
                        .toString() +
                    "min)",
                style: GoogleFonts.poppins(fontSize: 13)),
            Text("You should take a break and move!",
                style: GoogleFonts.poppins(fontSize: 13))
          ],
        );
      } else {
        return Column(
          children: [
            Text("Active.", style: GoogleFonts.poppins(fontSize: 13)),
            Text(
                "You have been working for: " +
                    ((context.watch<PauseProvider>().workTime / 1000 / 60 * 10)
                                .truncate() /
                            10)
                        .toString() +
                    "min",
                style: GoogleFonts.poppins(fontSize: 13))
          ],
        );
      }
    }

    Future<Widget> buildRMVWidget() async {
      if (!rmvActive) {
        return Text("Not active!", style: GoogleFonts.poppins(fontSize: 13));
      }
      if (locationData == null) {
        return Text("No Location data!",
            style: GoogleFonts.poppins(fontSize: 13));
      }
      // RMVService.getCurrentRMVStatus(locationData, latestActivity);\
      if (rmvActive) {
        _rmvStatus =
            await RMVService.getCurrentRMVStatus(locationData, latestActivity);
        if (_rmvStatus == RMVStatus.ONSTATION) {
          return Column(
            children: [
              Text("You are on a trainstation and waiting!",
                  style: GoogleFonts.poppins(fontSize: 13)),
              Text("Take a look at your connections",
                  style: GoogleFonts.poppins(fontSize: 13)),
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
              child: Column(
            children: [
              Text("Active.", style: GoogleFonts.poppins(fontSize: 13)),
              Text("You are too far away from a train station",
                  style: GoogleFonts.poppins(fontSize: 13)),
              Text("or you are in motion.",
                  style: GoogleFonts.poppins(fontSize: 13)),
            ],
          ));
        }
      } else {
        return Text("Not active.");
      }
    }

    Widget buildStatusWidget() {
      if (!rmvActive && !pauseActive && !alarmActive) {
        return Text("No information about Location and Activity Status");
      }
      if (locationData == null) {
        return Text("No location data.");
      } else {
        return Column(
          children: [
            Text("You are at longitute: " +
                locationData.longitude.toString() +
                " and latitute: " +
                locationData.latitude.toString()),
            Text("Your Activity Status: " + latestActivity.toString())
          ],
        );
      }
    }

    return Center(
      child: Column(
        children: [
          Card(
            child: Column(
              children: [
                Text(
                  'Status Alarm-Service: ',
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
                Divider(thickness: 2),
                buildAlarmWidget(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: Divider(thickness: 2, color: Color(0xFF164A5C)),
          ),
          Card(
            child: Column(
              children: [
                Text(
                  'Status MakeAPause-Service: ',
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
                Divider(thickness: 2),
                buildPauseWidget(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: Divider(thickness: 2, color: Color(0xFF164A5C)),
          ),
          FutureBuilder<Widget>(
              future: buildRMVWidget(),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                return Card(
                  child: Column(
                    children: [
                      Text(
                        'Status RMV-Service: ',
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                      Divider(thickness: 2),
                      snapshot.hasData
                          ? snapshot.requireData
                          : Text("Not active."),
                    ],
                  ),
                );
              }),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: Divider(thickness: 2, color: Color(0xFF164A5C)),
          ),
          Card(
              child: Column(
            children: [buildStatusWidget(), Divider(thickness: 2)],
          ))
        ],
      ),
    );
  }
}
