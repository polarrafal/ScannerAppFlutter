import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:scannerappflutter/constants/core/data_wedge_info.dart';
import 'package:scannerappflutter/constants/styles/styles_constants.dart';
import 'package:scannerappflutter/services/zebra_printer_service.dart';
import 'package:scannerappflutter/visuals/widgets/buttons/standard_button.dart';
import 'package:scannerappflutter/visuals/widgets/buttons/standard_navigation_back_button.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  static const EventChannel scanChannel = EventChannel(dwScan);
  final _barcodeTextEditingController = TextEditingController();
  final _zebraPrinterService = ZebraPrinterService();
  String _barcodeString = '';

  @override
  void initState() {
    super.initState();
    scanChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
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

  void printPressed() {
    var testPrinterIpAddress = '192.168.100.180';
    var printingData = '''
                          ^XA,
                          ^PQ1,
                          ^PW456,
                          ^POI,
                          ^LT0,
                          ^FO100,45^ADN^FD1000K^FS,
                          ^FO180,45^A0N,35,40^FD\$99.99^FS,
                          ^FO95,78^BY1^BCN,45,N,N^FD$_barcodeString^FS,
                          ^FO120,128^A0N,20,20^FD12 00 000000000 09999 00^FS,
                          ^XZ
                       ''';

    _zebraPrinterService.printZplAsync(testPrinterIpAddress, printingData);
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
                        onPressed: printPressed,
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
