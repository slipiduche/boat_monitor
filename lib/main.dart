import 'package:boat_monitor/providers/mqtt_provider.dart';
import 'package:boat_monitor/routes/routes.dart';
import 'package:boat_monitor/share_prefs/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:boat_monitor/generated/l10n.dart';

import 'bloc/alerts_bloc.dart';
import 'pages/login_page.dart';
import 'styles/colors.dart';

/// Forces portrait-only mode application-wide
/// Use this Mixin on the main app widget i.e. app.Dart
/// Flutter's 'App' has to extend Stateless widget.
///
/// Call `super.build(context)` in the main build() method
/// to enable portrait only mode
mixin PortraitModeMixin on StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return null;
  }
}

/// Forces portrait-only mode on a specific screen
/// Use this Mixin in the specific screen you want to
/// block to portrait only mode.
///
/// Call `super.build(context)` in the State's build() method
/// and `super.dispose();` in the State's dispose() method
mixin PortraitStatefulModeMixin<T extends StatefulWidget> on State<T> {
  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return null;
  }

  @override
  void dispose() {
    _enableRotation();
  }
}

/// blocks rotation; sets orientation to: portrait
void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void _enableRotation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();

  AlertsBloc().setAlertClosed = true;

  runApp(MyApp());
}

class MyApp extends StatelessWidget with PortraitModeMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ), //set desired text scale factor here
          child: child,
        );
      },
      theme: //ThemeData.lerp(
          ThemeData(
        backgroundColor: Colors.white,
        fontFamily: 'Roboto',
        primaryColor: blue1,
        accentColor: blue1,
        colorScheme: ColorScheme.light(
          primary: blue1,
        ),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: 'BoatMonitor App',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        TextLanguage.delegate
      ],
      supportedLocales: TextLanguage.delegate.supportedLocales,
      initialRoute: 'loginPage',
      routes: getAppRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        print('ruta llamada ${settings.name}');
        //Navigator.pop(context);
        return CupertinoPageRoute(
            builder: (BuildContext context) => LoginPage());
        // return MaterialPageRoute(
        //     builder: (BuildContext context) => LoginPage());
      },
    );
  }
}
//desde lap

/*
MaterialApp(
  builder:  (BuildContext context, Widget child) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0, ), //set desired text scale factor here
      child: child,
    );
  },
  title: 'Flutter Demo',
  theme: ThemeData(
    primarySwatch: Colors.blue,
  ),
  home: MyHomePage(title: 'Flutter Demo Home Page'),
);
*/