import 'package:flutter/material.dart';
import 'package:scannerappflutter/constants/styles/styles_constants.dart';
import 'package:scannerappflutter/services/data_wedge_service.dart';
import 'package:scannerappflutter/ui/app_route.dart';
import 'package:scannerappflutter/ui/screens/base_page/base_page.dart';
import 'package:scannerappflutter/ui/widgets/buttons/column_button/column_navigation_button.dart';
import 'package:scannerappflutter/ui/widgets/buttons/standard_button/standard_navigation_button.dart';

class StartScreen extends BasePage {
  const StartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends BasePageState<StartScreen> {
  static final DataWedgeService _dataWedgeService = DataWedgeService();

  @override
  void initState() {
    super.initState();
    _dataWedgeService.createProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          "Mobile scan&print",
                          style: kTitleTextStyle,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ColumnNavigationButton(
                              text: "Login",
                              destination: AppRoute.loginScreen,
                              context: context),
                          ColumnNavigationButton(
                              text: "Configuration",
                              destination: AppRoute.configurationScreen,
                              context: context),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
