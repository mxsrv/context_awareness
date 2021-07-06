import 'package:context_awareness/provider/ActivityProvider.dart';
import 'package:context_awareness/provider/AlarmProvider.dart';
import 'package:context_awareness/provider/LocationProvider.dart';
import 'package:context_awareness/provider/RMVProvider.dart';
import 'package:context_awareness/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:context_awareness/widgets/drawer.dart';
import 'package:provider/provider.dart';
//import 'package:context_awareness/widgets/home.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => RMVProvider()),
      ChangeNotifierProvider(create: (_) => AlarmProvider()),
      ChangeNotifierProvider(create: (_) => ActivityProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider())
    ],
    child: AwareMe(),
  )
  );

class AwareMe extends StatelessWidget {
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
          body: HomePage(),
        ));
  }
}
