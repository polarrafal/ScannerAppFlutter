import 'package:flutter/material.dart';
import 'package:scannerappflutter/ui/app_route.dart';
import 'package:scannerappflutter/ui/screens/configuration_screen/configuration_screen.dart';
import 'package:scannerappflutter/ui/screens/initialization_screen/initialization_screen.dart';
import 'package:scannerappflutter/ui/screens/login_screen/login_screen.dart';
import 'package:scannerappflutter/ui/screens/scanner_screen/scanner_screen.dart';
import 'package:scannerappflutter/ui/screens/start_screen/start_screen.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.grey.shade900),
      initialRoute: AppRoute.initializationScreen.name,
      routes: {
        AppRoute.initializationScreen.name: (context) =>
            const InitializationScreen(),
        AppRoute.startScreen.name: (context) => const StartScreen(),
        AppRoute.scannerScreen.name: (context) => const ScannerScreen(),
        AppRoute.configurationScreen.name: (context) =>
            const ConfigurationScreen(),
        AppRoute.loginScreen.name: (context) => const LoginScreen(),
      },
    );
  }
}
