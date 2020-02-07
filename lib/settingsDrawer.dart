import 'package:bloc_provider/bloc_provider.dart';
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
          child: Text(
            "Settings",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        StreamBuilder<bool>(
            stream: bloc.visibilityStream,
            initialData: bloc.visibilityStream.value,
            builder: (context, snapshot) {
              return SwitchListTile(
              value: snapshot.data,
              onChanged: (bool value) {
                bloc.toggleVisibility(value);
              },
              title: Text("Hide on Select"),
              subtitle:
                  Text("Hide the selected card until you tap the screen"),
                );
            })
      ],
    ));
  }
}