import 'package:flutter/material.dart';
import 'package:scannerappflutter/visuals/views/scanner_view.dart';
import 'package:scannerappflutter/visuals/views/start_view.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.grey.shade800),
      initialRoute: '/startView',
      routes: {
        '/startView': (context) => const StartView(),
        '/scannerView': (context) => const ScannerView(),
      },
    );
  }
}
