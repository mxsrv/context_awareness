import 'package:context_awareness/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16,
      child: ListView(
        children: [
          Container(
            height: 100.0,
            child: DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF164A5C)),
                child: Text(
                  "Menu",
                  style: GoogleFonts.poppins(fontSize: 26, color: Colors.white),
                )),
          ),
          ListTile(
            title: Text("Settings",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black)),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()),);},
          ),
          ListTile(
            title: Text("About",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
