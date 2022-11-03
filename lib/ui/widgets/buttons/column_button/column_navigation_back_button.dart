import 'package:flutter/material.dart';
import 'package:scannerappflutter/ui/widgets/buttons/standard_button/standard_navigation_back_button.dart';

class ColumnNavigationBackButton extends StatelessWidget {
  const ColumnNavigationBackButton(
      {super.key, required this.text, required this.context});

  final String text;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: StandardNavigationBackButton(context: context, text: text),
    );
  }
}
