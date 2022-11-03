import 'package:flutter/cupertino.dart';
import 'package:scannerappflutter/constants/styles/styles_constants.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: kTitleTextStyle,
      ),
    );
  }
}
