import 'dart:io';

import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:context_awareness/logic/rmvservice.dart';
import 'package:context_awareness/provider/ActivityProvider.dart';
import 'package:context_awareness/provider/LocationProvider.dart';
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
  @override
  Widget build(BuildContext context) {
    ActivityEvent latestActivity = context.watch<ActivityProvider>().latestActivity;
    LocationData? locationData = context.watch<LocationProvider>().latestLocationData;

    Text switchContext() {
      if(locationData != null){
        RMVService.getCurrentRMVStatus(locationData, latestActivity);
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
            ],
          ),
        ),
      ),
    );
  }
}
