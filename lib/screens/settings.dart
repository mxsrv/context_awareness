import 'package:context_awareness/provider/ActivityProvider.dart';
import 'package:context_awareness/provider/AlarmProvider.dart';
import 'package:context_awareness/provider/LocationProvider.dart';
import 'package:context_awareness/provider/PauseProvider.dart';
import 'package:context_awareness/provider/RMVProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../logic/rmvservice.dart';
import '../logic/alarmservice.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    _switchRMV(bool value) {
      if (value) {
        context.read<ActivityProvider>().startTracking();
        context.read<LocationProvider>().startLocationService();
        context.read<RMVProvider>().setActive();
      } else {
        context.read<RMVProvider>().setInactive();
      }
    }

    _switchAlarmClock(bool value) {
      if (value) {
        context.read<ActivityProvider>().startTracking();
        context.read<LocationProvider>().startLocationService();
        context.read<AlarmProvider>().setActive();
      } else {
        context.read<AlarmProvider>().setInactive();
      }
    }

    _switchPause(bool value) {
      if (value) {
        context.read<ActivityProvider>().startTracking();
        context.read<LocationProvider>().startLocationService();
        context.read<PauseProvider>().setActive();
      } else {
        context.read<PauseProvider>().setInactive();
      }
    }

    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.start, //align the button to the left side
            children: [
              IconButton(
                  //button initialisation
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color(0xFF164A5C),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              Text(
                '   Settings',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF164A5C)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Divider(
            thickness: 2,
            color: Color(0xFF164A5C)
          ),
          Card(
              child: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'Alarm Service',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Evening Alarm Reminder',
                          style: TextStyle(
                              color: Color(0xFF164A5C), fontSize: 12)),
                    ],
                  ),
                ),
                Switch(
                    value: context.watch<AlarmProvider>().alarmActive,
                    onChanged: (value) {
                      _switchAlarmClock(value);
                    },
                    activeColor: Colors.grey,
                    activeTrackColor: Color(0xFF164A5C),
                    inactiveThumbColor: Color(0xFF164A5C),)
              ],
            ),
          )),
          Card(
              child: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'Train Service',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                          text: '  Open RMV Timetable',
                          style: TextStyle(
                              color: Color(0xFF164A5C), fontSize: 12)),
                    ],
                  ),
                ),
                Switch(
                    value: context.watch<RMVProvider>().rmvActive,
                    onChanged: (value) {
                      _switchRMV(value);
                    },
                    activeColor: Colors.grey,
                    activeTrackColor: Color(0xFF164A5C),
                    inactiveThumbColor: Color(0xFF164A5C))
              ],
            ),
          )),
          Card(
              child: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'Pause Service',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Take-A-Pause Reminder',
                          style: TextStyle(
                              color: Color(0xFF164A5C), fontSize: 12)),
                    ],
                  ),
                ),
                Switch(
                    value: context.watch<PauseProvider>().workTimerActive,
                    onChanged: (value) {
                      _switchPause(value);
                    },
                    activeColor: Colors.grey,
                    activeTrackColor: Color(0xFF164A5C),
                    inactiveThumbColor: Color(0xFF164A5C))
              ],
            ),
          )),
        ],
      ),
    ));
  }
}
