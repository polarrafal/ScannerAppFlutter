import 'package:flutter/material.dart';
import 'package:scannerappflutter/visuals/widgets/buttons/standard_button.dart';

class StandardNavigationButton extends StatelessWidget {
  const StandardNavigationButton(
      {super.key,
      required this.text,
      required this.destination,
      required this.context});

  final String text;
  final String destination;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return StandardButton(
      text: text,
      onPressed: (() => {
            Navigator.of(context).pushNamed(destination),
          }),
    );
  }
}
