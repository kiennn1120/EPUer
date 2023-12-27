import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../utils/dimens/dimens_manager.dart';
import '../../utils/routes/routes.dart';
import '../../utils/routes/routes_name.dart';
import 'l10n/localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 4));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DimensManager();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTEer',
      themeMode: ThemeMode.light,
      theme: ThemeData(fontFamily: 'Nunito'),
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.routeBuilder,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..maxConnectionsPerHost = 5
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
