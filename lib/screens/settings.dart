import 'package:flutter/material.dart';

import '../logic/rmvservice.dart';
import '../logic/alarmservice.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _alarm = false;
  bool _rmv = false;

  _switchAlarmClock(bool value) {
    if(value){
      AlarmService.startAlarmService();
    }
    else{
      AlarmService.stopAlarmService();
    }
  }

  _switchRMV(bool value) {
    if(value){
      RMVService.startRMVService();
    }
    else{
      RMVService.stopRMVService();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    value: _alarm,
                    onChanged: (value) {_switchAlarmClock(value);},
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
                    value: _rmv,
                    onChanged: (value) {_switchRMV(value);},
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
