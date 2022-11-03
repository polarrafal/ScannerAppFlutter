import 'package:flutter/material.dart';
import 'package:scannerappflutter/constants/styles/styles_constants.dart';

class StandardButton extends StatelessWidget {
  const StandardButton(
      {super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: kStandardButtonBackgroundColor,
        height: kStandardButtonHeight,
        child: Center(
          child: Text(
            text,
            style: kStandardButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
