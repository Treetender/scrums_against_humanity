import 'package:bloc_provider/bloc_provider.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:scrums_against_humanity/settingsBloc.dart';

class SettingsDrawer extends StatefulWidget {
  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingsBloc>(context);

    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Align(
              child: Text(
                "Settings",
                style: Theme.of(context).textTheme.headline5,
              ),
              alignment: Alignment.bottomLeft),
        ),
        StreamBuilder<bool>(
            stream: bloc.visibilityStream,
            initialData: bloc.visibilityStream.value,
            builder: (context, snapshot) {
              return SwitchListTile(
                activeColor: Theme.of(context).accentColor,
                value: snapshot.data,
                onChanged: (bool value) {
                  bloc.toggleVisibility(value);
                },
                title: Text("Hide on Select"),
                subtitle:
                    Text("Hide the selected card until you tap the screen"),
              );
            }),
        SwitchListTile(
          onChanged: (bool value) {
            DynamicTheme.of(context)
                .setBrightness(value ? Brightness.dark : Brightness.light);
            DynamicTheme.of(context)
                .setThemeData(value ? bloc.darkTheme : bloc.lightTheme);
          },
          value: DynamicTheme.of(context).brightness == Brightness.dark,
          title: Text("Switch to Dark Theme"),
          activeColor: Theme.of(context).accentColor,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
          child: Align(
              child: Text(
                "Decks",
                style: Theme.of(context).textTheme.headline6,
              ),
              alignment: Alignment.bottomLeft),
        ),
        Divider(),
        _deckSelector(context),
      ],
    ));
  }

  Widget _deckSelector(BuildContext context) {
    final bloc = BlocProvider.of<SettingsBloc>(context);

    return StreamBuilder<ScrumDecks>(
        initialData: bloc.chosenDeckStream.value,
        stream: bloc.chosenDeckStream,
        builder: (context, snapshot) {
          return Column(children: [
            RadioListTile(
              title: Text("Standard"),
              groupValue: snapshot.data,
              value: ScrumDecks.standard,
              onChanged: (ScrumDecks deck) {
                bloc.toggleDeck(deck);
              },
              activeColor: Theme.of(context).accentColor,
            ),
            RadioListTile(
              title: Text("Fibonacci"),
              groupValue: snapshot.data,
              value: ScrumDecks.fibonacci,
              onChanged: (ScrumDecks deck) {
                bloc.toggleDeck(deck);
              },
              activeColor: Theme.of(context).accentColor,
            ),
            RadioListTile(
              title: Text("T-Shirt"),
              groupValue: snapshot.data,
              value: ScrumDecks.size,
              onChanged: (ScrumDecks deck) {
                bloc.toggleDeck(deck);
              },
              activeColor: Theme.of(context).accentColor,
            ),
          ]);
        });
  }
}
