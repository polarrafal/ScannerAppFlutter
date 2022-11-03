import 'package:flutter/material.dart';
import 'package:scannerappflutter/ui/app_route.dart';
import 'package:scannerappflutter/ui/widgets/buttons/standard_button/standard_navigation_button.dart';

class ColumnNavigationButton extends StatelessWidget {
  const ColumnNavigationButton(
      {super.key,
      required this.text,
      required this.destination,
      required this.context});

  final String text;
  final AppRoute destination;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: StandardNavigationButton(
            context: context, destination: destination, text: text));
  }
}
