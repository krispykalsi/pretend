import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretend/application/router/router.gr.dart';
import 'package:pretend/injection_container.dart' as di;
import 'package:pretend/presentation/common/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appDelegate = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(GoogleFonts.ptSansNarrow(
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.DARK,
              ),
            )),
            backgroundColor: MaterialStateProperty.all(AppColors.ACCENT),
            foregroundColor: MaterialStateProperty.all(AppColors.DARK),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            ),
          ),
        ),
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
      routerDelegate: _appDelegate.delegate(),
      routeInformationParser: _appDelegate.defaultRouteParser(),
    );
  }
}
