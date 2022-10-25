import 'package:flutter/material.dart';
import 'package:scannerappflutter/constants/styles/styles_constants.dart';
import 'package:scannerappflutter/services/data_wedge_service.dart';
import 'package:scannerappflutter/visuals/widgets/buttons/standard_navigation_button.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
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
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: StandardNavigationButton(
                                text: "Scanner",
                                destination: '/scannerView',
                                context: context),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
