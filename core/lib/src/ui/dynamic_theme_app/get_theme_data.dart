part of 'dynamic_theme_app.dart';

ThemeData get _getThemeData {
  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(primary: AppColors.accent),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(GoogleFonts.ptSansNarrow(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.DARK,
          ),
        )),
        backgroundColor: MaterialStateProperty.all(AppColors.accent),
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
          color: AppColors.accent,
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
  );
}
