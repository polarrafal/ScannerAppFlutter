enum AppRoute {
  initializationScreen,
  scannerScreen,
  startScreen,
  loginScreen,
  configurationScreen,
}

extension AppNamedRouteExtension on AppRoute {
  String get name {
    switch (this) {
      case AppRoute.initializationScreen:
        return 'initialization_screen';
      case AppRoute.startScreen:
        return 'start_screen';
      case AppRoute.scannerScreen:
        return 'scanner_screen';
      case AppRoute.loginScreen:
        return 'login_screen';
      case AppRoute.configurationScreen:
        return 'configuration_screen';
    }
  }
}
