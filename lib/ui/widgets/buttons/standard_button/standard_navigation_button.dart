import 'package:flutter/material.dart';
import 'package:scannerappflutter/ui/app_route.dart';
import 'package:scannerappflutter/ui/widgets/buttons/standard_button/standard_button.dart';

class StandardNavigationButton extends StatelessWidget {
  const StandardNavigationButton(
      {super.key,
      required this.text,
      required this.destination,
      required this.context});

  final String text;
  final AppRoute destination;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return StandardButton(
      text: text,
      onPressed: (() async => {
            await Navigator.of(context).pushNamed(destination.name),
          }),
    );
  }
}
