import 'package:zsdk/zsdk.dart';

class ZebraPrinterService {
  final zsdk = ZSDK();
  final printerPort = 9100;

  Future<void> calibratePrinterAsync(String printerIpAddress) async {
    await zsdk.doManualCalibrationOverTCPIP(
        address: printerIpAddress, port: printerPort);
  }

  Future<PrinterSettings?> getPrinterSettingsAsync(
      String printerIpAddress) async {
    var printerResponse = await zsdk.getPrinterSettingsOverTCPIP(
        address: printerIpAddress, port: printerPort);

    final printerSettings = PrinterResponse.fromMap(printerResponse).settings;
    return printerSettings;
  }

  Future<PrinterResponse> checkPrinterStatusAsync(
      String printerIpAddress) async {
    var printerStatus = await zsdk.checkPrinterStatusOverTCPIP(
        address: printerIpAddress, port: printerPort);

    final printerResponse = PrinterResponse.fromMap(printerStatus);
    return printerResponse;
  }

  Future<PrinterResponse?> printZplAsync(
      String printingData, String printerIpAddress) async {
    try {
      var printingResponse = await zsdk.printZplDataOverTCPIP(
          data: printingData, address: printerIpAddress, port: printerPort);

      final printerResponse = PrinterResponse.fromMap(printingResponse);
      return printerResponse;
    } catch (e) {
      // Todo: handle exception
      return null;
    }
  }
}
