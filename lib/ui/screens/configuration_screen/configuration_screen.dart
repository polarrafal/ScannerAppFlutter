import 'package:flutter/material.dart';
import 'package:scannerappflutter/services/configuration_service.dart';
import 'package:scannerappflutter/ui/screens/base_page/base_page.dart';
import 'package:scannerappflutter/ui/widgets/buttons/column_button/column_button.dart';
import 'package:scannerappflutter/ui/widgets/buttons/column_button/column_navigation_back_button.dart';
import 'package:scannerappflutter/ui/widgets/spinner/loading_spinner.dart';
import 'package:scannerappflutter/ui/widgets/title/title.dart';

class ConfigurationScreen extends BasePage {
  const ConfigurationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ConfigurationViewState createState() => _ConfigurationViewState();
}

class _ConfigurationViewState extends BasePageState<ConfigurationScreen> {
  final _baseUrlTextEditingController = TextEditingController();
  final _printerIpTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    updateTextUI();
  }

  @override
  Widget build(BuildContext context) {
    if (isBusy) {
      return const LoadingSpinner();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: const PageTitle(text: 'Configuration'),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Base url'),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: _baseUrlTextEditingController,
                        style: const TextStyle(letterSpacing: 2.0),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'base url',
                        ),
                      ),
                    ),
                    const Text('Printer IP address'),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: _printerIpTextEditingController,
                        style: const TextStyle(letterSpacing: 2.0),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'printer IP address',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  ColumnButton(
                      text: 'Submit', onPressed: () async => submitCommand()),
                  ColumnButton(
                      text: 'Clear', onPressed: () async => clearCommand()),
                  ColumnNavigationBackButton(context: context, text: 'Back')
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future clearCommand() async {
    await busyActionAsync(clear());
  }

  Future submitCommand() async {
    await busyActionAsync(submit());
  }

  void updateTextUI() {
    _baseUrlTextEditingController.text = ConfigurationService.baseUrl;
    _printerIpTextEditingController.text =
        ConfigurationService.printerIpAddress;
  }

  Future clear() async {
    ConfigurationService.baseUrl = '';
    ConfigurationService.printerIpAddress = '';
    updateTextUI();
  }

  Future submit() async {
    var baseUrlCandidate = _baseUrlTextEditingController.text;
    var printerIpCandidate = _printerIpTextEditingController.text;

    if (baseUrlCandidate.isEmpty || printerIpCandidate.isEmpty) {
      return;
    }

    ConfigurationService.baseUrl = baseUrlCandidate;
    ConfigurationService.printerIpAddress = printerIpCandidate;
    updateTextUI();
  }
}
