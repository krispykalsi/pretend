import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/timetable/presentation/widgets/timetable_view.dart';

void main() {
  runApp(MyApp());
}

const PRIMARY = Color(0xffffffff);
const SECONDARY = Color(0xff9c9c9c);
const ACCENT = Color(0xffffc2c2);
const DARK = Color(0xff242424);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: GoogleFonts.yanoneKaffeesatz(
            textStyle: TextStyle(
              fontSize: 72,
              color: SECONDARY,
            ),
          ),
          headline2: GoogleFonts.yanoneKaffeesatz(
            textStyle: TextStyle(
              fontSize: 48,
              color: ACCENT,
            ),
          ),
          headline3: GoogleFonts.ptSansNarrow(
            textStyle: TextStyle(
              fontSize: 24,
              color: PRIMARY,
            ),
          ),
          bodyText1: GoogleFonts.ptSansNarrow(
            textStyle: TextStyle(
              fontSize: 18,
              color: PRIMARY,
            ),
          ),
          bodyText2: GoogleFonts.ptSansNarrow(
            textStyle: TextStyle(
              fontSize: 18,
              color: SECONDARY,
            ),
          ),
        ),
      ),
      home: TimetableView(),
    );
  }
}
