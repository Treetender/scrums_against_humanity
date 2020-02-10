import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AutosizedText extends StatelessWidget {
  final String text;
  final Color textColor;

  AutosizedText(this.text, this.textColor);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: Text(
          text,
          style: TextStyle(inherit: true, color: textColor),
        ),
        fit: BoxFit.contain);
  }
}
