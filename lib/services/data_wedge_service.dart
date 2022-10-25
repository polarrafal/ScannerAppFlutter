import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../../constants/core/data_wedge_info.dart';

class DataWedgeService {
  static const MethodChannel _methodChannel = MethodChannel(dwCommand);
  static const _profileName = "DataWedgeFlutterDemo";

  Future<void> sendDataWedgeCommand(String command, String parameter) async {
    try {
      String argumentAsJson =
          jsonEncode({"command": command, "parameter": parameter});

      await _methodChannel.invokeMethod(
          'sendDataWedgeCommandStringParameter', argumentAsJson);
    } on PlatformException {
      //  Error invoking Android method
    }
  }

  Future<void> createProfile() async {
    try {
      await _methodChannel.invokeMethod('createDataWedgeProfile', _profileName);
    } on PlatformException {
      //  Error invoking Android method
    }
  }

  Future<void> startScanCommand() async {
    sendDataWedgeCommand(
        "com.symbol.datawedge.api.SOFT_SCAN_TRIGGER", "START_SCANNING");
  }

  Future<void> stopScanCommand() async {
    sendDataWedgeCommand(
        "com.symbol.datawedge.api.SOFT_SCAN_TRIGGER", "STOP_SCANNING");
  }
}
