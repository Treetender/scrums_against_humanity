import 'package:flutter/material.dart';
import 'package:scrums_against_humanity/autosizeText.dart';

class ChosenCard extends StatelessWidget {
  final String value;

  ChosenCard(this.value);

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          margin: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.onSurface, width: 5.0),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  child: Text(this.value,
                      style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Theme.of(context).colorScheme.onSurface)),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Expanded(child: AutosizedText(this.value), flex: 1),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    child: Text(this.value,
                        style: Theme.of(context).textTheme.headline2.copyWith(
                            color: Theme.of(context).colorScheme.onSurface)),
                    alignment: Alignment.centerRight),
              ),
            ],
          ),
        ),
      );
}
