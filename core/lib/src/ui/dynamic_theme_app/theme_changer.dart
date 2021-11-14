part of 'dynamic_theme_app.dart';

class ThemeChanger extends InheritedWidget {
  static ThemeChanger? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeChanger>();
  }

  final GlobalKey _appThemeKey;

  ThemeChanger({
    required GlobalKey appThemeKey,
    required Widget child,
  })  : _appThemeKey = appThemeKey,
        super(child: child);

  set accentColor(Color accent) {
    AppColors.accent = accent;
    (_appThemeKey.currentState as DynamicThemeAppState?)?.theme = _getThemeData;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
