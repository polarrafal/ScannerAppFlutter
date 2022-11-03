import 'package:flutter/material.dart';
import 'package:scannerappflutter/ui/widgets/buttons/standard_button/standard_button.dart';

class StandardNavigationBackButton extends StatelessWidget {
  const StandardNavigationBackButton(
      {super.key, required this.text, required this.context});

  final String text;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return StandardButton(
      text: text,
      onPressed: (() => {Navigator.of(context).pop()}),
    );
  }
}
