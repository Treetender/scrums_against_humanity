import 'package:flutter/material.dart';
import 'package:scrums_against_humanity/autosizeText.dart';

class ChosenCard extends StatelessWidget {
  final String value;

  ChosenCard(this.value);

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          margin: EdgeInsets.all(24.0),
          padding: EdgeInsets.all(8.0),
          decoration: ShapeDecoration(
              shadows: [
                BoxShadow(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.red[900]
                      : Colors.indigo[800],
                  blurRadius: 20.0, // has the effect of softening the shadow
                  spreadRadius: 1.0, // has the effect of extending the shadow
                  offset: Offset(
                    10.0, // horizontal,
                    10.0, // vertical
                  ),
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              color: Theme.of(context).colorScheme.secondary),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  child: Text(this.value,
                      style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary)),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Expanded(
                  child: AutosizedText(
                      this.value, Theme.of(context).colorScheme.onSecondary),
                  flex: 1),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    child: Text(this.value,
                        style: Theme.of(context).textTheme.headline2.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary)),
                    alignment: Alignment.centerRight),
              ),
            ],
          ),
        ),
      );
}
