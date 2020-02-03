import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrums Against Humanity',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Scrums Against Humanity'),
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
      body: Center(
          child: GridView.builder(
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          return ScrumCard(_cards[index]);
        },
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                (MediaQuery.of(context).orientation == Orientation.portrait)
                    ? 2
                    : 3),
      )),
    );
  }
}

class SelectedCardPage extends StatelessWidget {
  final String value;

  SelectedCardPage(this.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InkWell(
          onTap: () => Navigator.of(context).pop(),
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            margin: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 5.0),
            ),
            child: Column(
              children: <Widget>[
                Expanded(child: AutosizedText(this.value), flex: 1),
                Expanded(child: AutosizedText(this.value), flex: 6),
                Expanded(child: AutosizedText(this.value), flex: 1),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class AutosizedText extends StatelessWidget {
  final String text;

  AutosizedText(this.text);

  @override
  Widget build(BuildContext context) {
    return FittedBox(child: Text(text), fit: BoxFit.contain);
  }
}

class ScrumCard extends StatelessWidget {
  final String value;

  ScrumCard(this.value);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SelectedCardPage(value))),
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              style: TextStyle(inherit: true, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
