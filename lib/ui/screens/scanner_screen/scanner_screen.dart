import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:scannerappflutter/constants/core/data_wedge_info.dart';
import 'package:scannerappflutter/constants/styles/styles_constants.dart';
import 'package:scannerappflutter/services/configuration_service.dart';
import 'package:scannerappflutter/services/zebra_printer_service.dart';
import 'package:scannerappflutter/ui/screens/base_page/base_page.dart';
import 'package:scannerappflutter/ui/widgets/buttons/standard_button/standard_button.dart';
import 'package:scannerappflutter/ui/widgets/buttons/standard_button/standard_navigation_back_button.dart';
import 'package:zsdk/zsdk.dart';

class ScannerScreen extends BasePage {
  const ScannerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends BasePageState<ScannerScreen> {
  static const EventChannel scanChannel = EventChannel(dwScan);
  final _barcodeTextEditingController = TextEditingController();
  final _zebraPrinterService = ZebraPrinterService();
  String _barcodeString = '';

  @override
  void initState() {
    super.initState();
    scanChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  @override
  void dispose() {
    _barcodeTextEditingController.dispose();
    super.dispose();
  }

  void _onEvent(event) {
    setState(() {
      Map barcodeScan = jsonDecode(event);
      _barcodeString = barcodeScan['scanData'];
      _barcodeTextEditingController.text = _barcodeString;
    });
  }

  void _onError(Object error) {
    setState(() {
      _barcodeTextEditingController.text = '';
    });
  }

  Future printPressedCommand() async {
    await busyActionAsync(printPressed());
  }

  Future<PrinterResponse?> printPressed() async {
    // sample zebra definition from zebra docs
    var printingData = '''
^XA,
^FO100,35^BY1^BCN,100,N,N^FD1234123412341234^FS,
^XZ
                       ''';

    var printingResult = await _zebraPrinterService.printZplAsync(
        printingData, ConfigurationService.printerIpAddress);

    return printingResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "Scanner",
                  style: kTitleTextStyle,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: const Center(
                        child: Text(
                          "Please scan item",
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextField(
                        enabled: false,
                        textAlign: TextAlign.center,
                        controller: _barcodeTextEditingController,
                        style: const TextStyle(letterSpacing: 2.0),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'scanned barcode',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: StandardButton(
                        onPressed: printPressedCommand,
                        text: "Print",
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: StandardNavigationBackButton(
                        context: context,
                        text: "Back",
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
