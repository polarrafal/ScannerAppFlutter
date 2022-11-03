import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:scannerappflutter/services/data_wedge_service.dart';
import 'package:scannerappflutter/ui/app_route.dart';
import 'package:scannerappflutter/ui/screens/base_page/base_page.dart';
import 'package:scannerappflutter/ui/widgets/spinner/loading_spinner.dart';

class InitializationScreen extends BasePage {
  const InitializationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StartViewState createState() => _StartViewState();
}

class _StartViewState extends BasePageState<InitializationScreen> {
  static final DataWedgeService _dataWedgeService = DataWedgeService();

  @override
  void initState() {
    super.initState();
    initializeApp();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamed(AppRoute.startScreen.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingSpinner();
  }

  void initializeApp() {
    _dataWedgeService.createProfile();
  }
}
