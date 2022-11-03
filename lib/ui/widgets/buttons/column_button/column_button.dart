import 'package:flutter/material.dart';
import 'package:scannerappflutter/ui/widgets/buttons/standard_button/standard_button.dart';

class ColumnButton extends StatelessWidget {
  const ColumnButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: StandardButton(text: text, onPressed: onPressed),
    );
  }
}
