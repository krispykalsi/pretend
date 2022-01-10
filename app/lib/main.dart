import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:core/dynamic_theme_app.dart';
import 'package:flutter/material.dart';
import 'package:pretend/application/router/router.gr.dart';
import 'package:pretend/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'default_channel',
        channelName: 'All notifications',
        channelDescription: 'For all class notifications',
        ledColor: Colors.white,
      )
    ],
    debug: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appDelegate = AppRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicThemeApp(
      buildChild: (themeData) {
        return MaterialApp.router(
          theme: themeData,
          themeMode: ThemeMode.dark,
          routerDelegate: _appDelegate.delegate(),
          routeInformationParser: _appDelegate.defaultRouteParser(),
        );
      },
    );
  }
}
