import 'package:flutter/widgets.dart';

class AutosizedText extends StatelessWidget {
  final String text;

  AutosizedText(this.text);

  @override
  Widget build(BuildContext context) {
    return FittedBox(child: Text(text), fit: BoxFit.contain);
  }
}