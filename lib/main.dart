import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:product_hunt_app/generated/l10n.dart';
import 'package:product_hunt_app/ui/splash.dart';
import 'package:product_hunt_app/utils/app_routes.dart';
import 'package:product_hunt_app/utils/app_theme.dart';
import 'services/app_preferences/app_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences().init();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().lightTheme(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Splash(),
      onGenerateRoute: AppRouteSetting().onGenerateRoute(),
    );
  }
}
