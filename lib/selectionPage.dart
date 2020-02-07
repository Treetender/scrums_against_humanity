
import 'package:flutter/material.dart';
import 'package:scrums_against_humanity/chosenCard.dart';

class SelectionPage extends StatefulWidget {
  final String value;
  final bool hiddenOnStart;

  SelectionPage(this.value, this.hiddenOnStart);

  @override
  _SelectedPageState createState() => _SelectedPageState(hiddenOnStart);
}

class _SelectedPageState extends State<SelectionPage> {
  bool visible;

  _SelectedPageState(this.visible);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InkWell(
        onTap: () {
          if (!visible) {
            setState(() {
              visible = true;
            });
          } else {
            Navigator.pop(context);
          }
        },
        child: Center(
          child: AnimatedOpacity(
              opacity: visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: ChosenCard(this.widget.value)),
        ),
      ),
    );
  }
}