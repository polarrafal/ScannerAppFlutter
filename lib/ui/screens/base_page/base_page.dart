import 'dart:async';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  bool _isBusy = false;

  bool get isBusy {
    return _isBusy;
  }

  void _setBusy() {
    setState(() {
      _isBusy = true;
    });
  }

  void _unsetBusy() {
    setState(() {
      _isBusy = false;
    });
  }

  Future busyActionAsync(Future function) async {
    try {
      _setBusy();

      // simulate app processing for PoC
      await Future.delayed(const Duration(milliseconds: 500));
      await function;
    } finally {
      _unsetBusy();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
