import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretend/presentation/common/app_colors.dart';
import 'package:pretend/presentation/setup/subjects/setup_subjects_page.dart';

void main() {
  runApp(MyApp());
}

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
              color: AppColors.SECONDARY,
            ),
          ),
          headline2: GoogleFonts.yanoneKaffeesatz(
            textStyle: TextStyle(
              fontSize: 48,
              color: AppColors.ACCENT,
            ),
          ),
          headline3: GoogleFonts.ptSansNarrow(
            textStyle: TextStyle(
              fontSize: 24,
              color: AppColors.PRIMARY,
            ),
          ),
          bodyText1: GoogleFonts.ptSansNarrow(
            textStyle: TextStyle(
              fontSize: 18,
              color: AppColors.PRIMARY,
            ),
          ),
          bodyText2: GoogleFonts.ptSansNarrow(
            textStyle: TextStyle(
              fontSize: 18,
              color: AppColors.SECONDARY,
            ),
          ),
        ),
      ),
      home: SetupSubjectsPage(),
    );
  }
}
