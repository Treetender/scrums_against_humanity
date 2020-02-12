import 'dart:ui';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:scrums_against_humanity/scrumCard.dart';
import 'package:scrums_against_humanity/selectionPage.dart';
import 'package:scrums_against_humanity/settingsBloc.dart';
import 'package:scrums_against_humanity/settingsDrawer.dart';

void main() => runApp(
      BlocProvider<SettingsBloc>(
        creator: (_context, _bag) => SettingsBloc(),
        child: App(),
      ),
    );

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingsBloc>(context);
    return DynamicTheme(
      data: (brightness) =>
          brightness == Brightness.dark ? bloc.darkTheme : bloc.lightTheme,
      themedWidgetBuilder: (context, theme) => MaterialApp(
        title: 'Scrums Against Humanity',
        theme: theme,
        home: MyHomePage(title: 'Scrums Against Humanity'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _cards = [
    "0",
    "1/2",
    "1",
    "2",
    "3",
    "5",
    "8",
    "13",
    "20",
    "40",
    "100",
    "∞",
    "ESC"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: SettingsDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
            child: GridView.builder(
          itemCount: _cards.length,
          itemBuilder: (context, index) {
            return ClickableScrumCard(_cards[index]);
          },
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (MediaQuery.of(context).size.width > 1000)
                  ? 4
                  : MediaQuery.of(context).size.width >= 600 ? 3 : 2),
        )),
      ),
    );
  }
}

class ClickableScrumCard extends StatelessWidget {
  final String value;

  ClickableScrumCard(this.value);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingsBloc>(context);
    return StreamBuilder<bool>(
        stream: bloc.visibilityStream,
        initialData: bloc.visibilityStream.value,
        builder: (context, snapshot) {
          return Tooltip(
            message: "Select ${this.value}",
            waitDuration: Duration(seconds: 2),
                      child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SelectionPage(value, !snapshot.data))),
              child: ScrumCard(value, false)
            ),
          );
        });
  }
}
