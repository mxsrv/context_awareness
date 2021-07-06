import 'package:context_awareness/provider/ActivityProvider.dart';
import 'package:context_awareness/provider/AlarmProvider.dart';
import 'package:context_awareness/provider/LocationProvider.dart';
import 'package:context_awareness/provider/PauseProvider.dart';
import 'package:context_awareness/provider/RMVProvider.dart';
import 'package:flutter/material.dart';
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
                    color: Colors.black45,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              Text(
                '   Einstellungen',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black45),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Divider(
            thickness: 2,
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
                    text: 'Wecker einstellen',
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Der Wecker wird eingestellt',
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                Switch(
                    value: context.watch<AlarmProvider>().alarmActive,
                    onChanged: (value) {
                      _switchAlarmClock(value);
                    },
                    activeColor: Colors.black,
                    activeTrackColor: Colors.green)
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
                    text: 'RMV aktvieren',
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: '  RMV am Bahnhof öffnen',
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                Switch(
                    value: context.watch<RMVProvider>().rmvActive,
                    onChanged: (value) {
                      _switchRMV(value);
                    },
                    activeColor: Colors.black,
                    activeTrackColor: Colors.green)
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
                    text: 'activate pause timer',
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'take a pause every 2 hours',
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                Switch(
                    value: context.watch<PauseProvider>().workTimerActive,
                    onChanged: (value) {
                      _switchPause(value);
                    },
                    activeColor: Colors.black,
                    activeTrackColor: Colors.green)
              ],
            ),
          )),
        ],
      ),
    ));
  }
}
