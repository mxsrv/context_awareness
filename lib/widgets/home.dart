import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment(0, -0.9),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'This is your current status:',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
