import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ScrumDecks {
    standard,
    fibonacci,
    size
}

class SettingsBloc extends Bloc {

  final _standardCards = ["0", "1/2", "1", "2", "3", "5", "8","13","20", "40", "100", "∞", "ESC" ];
  final _sizeCards = ["XS", "S", "M", "L", "XL", "XXL", "XXXL", "∞", "ESC" ];
  final _fibCards = ["0", "1", "2", "3", "5", "8", "13", "21", "34", "55", "89", "∞", "ESC"];

  final lightTheme = ThemeData(
    accentColor: Colors.indigoAccent[100],
    primaryColor: Colors.white,
    brightness: Brightness.light,
  );

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    accentColor: Colors.orangeAccent[200],
  );

  bool _visibility = true;
  final _chosenDeckController = BehaviorSubject.seeded(ScrumDecks.standard);
  final _visibilityController = BehaviorSubject<bool>.seeded(false);
  final _themeController = BehaviorSubject<ThemeData>();
  final _deckController = BehaviorSubject<List<String>>();
  final _hiddenOnSelectSettingsKey = "hiddenOnSelect";
  final _themeSettingKey = "activeTheme";
  final _chosenDeckKey = "chosenDeck";

  SettingsBloc() {
    _visibilityController.sink.add(_visibility);
    _themeController.sink.add(lightTheme);
    _deckController.sink.add(_standardCards);
    SharedPreferences.getInstance()
      .then((value) { 
        _visibilityController.sink.add(value.getBool(_hiddenOnSelectSettingsKey) ?? _visibility);
        _themeController.sink.add(value.get(_themeSettingKey) ?? lightTheme);

        var deck = _getDeckFromString(value.getString(_chosenDeckKey) ?? "Standard");
        _deckController.sink.add(_getCardsForDeck(deck));
        _chosenDeckController.sink.add(deck);
      });
  }

  bool get selectedVisibility => _visibility;
  ValueStream<bool> get visibilityStream => _visibilityController.stream;
  ValueStream<List<String>> get activeDeckStream => _deckController.stream;
  ValueStream<ScrumDecks> get chosenDeckStream => _chosenDeckController.stream;
  ValueStream<ThemeData> get activeThemeStream => _themeController.stream;

  void toggleVisibility(bool visible) {
    _visibility = visible;
    _visibilityController.sink.add(visible);
    SharedPreferences.getInstance()
      .then((value) => value.setBool(_hiddenOnSelectSettingsKey, visible));
  }

  ScrumDecks _getDeckFromString(String deckName) {
    switch(deckName) {
      case "Fibonacci":
        return ScrumDecks.fibonacci;
      case "Size":
        return ScrumDecks.size;
      default:
        return ScrumDecks.standard;
    }
  }

  List<String> _getCardsForDeck(ScrumDecks deck) {
    switch(deck) {
      case ScrumDecks.fibonacci:
        return _fibCards;
      case ScrumDecks.size:
        return _sizeCards;
      default:
        return _standardCards;
    }
  } 

  String _getStringFromDeck(ScrumDecks deck) {
    switch(deck) {
      case  ScrumDecks.fibonacci:
        return "Fibonacci";
      case ScrumDecks.size:
        return "Size";
      default:
        return "Standard";
    }
  }


  void toggleDeck(ScrumDecks deckChoice) {
    switch(deckChoice) {
      case ScrumDecks.standard:
        _deckController.sink.add(_standardCards);
        break;
      case ScrumDecks.fibonacci:
        _deckController.sink.add(_fibCards);
        break;
      case ScrumDecks.size:
        _deckController.sink.add(_sizeCards);
        break;
    }
    
    SharedPreferences.getInstance()
      .then((value) => value.setString(_chosenDeckKey, _getStringFromDeck(deckChoice)));

    _chosenDeckController.sink.add(deckChoice);
  }

  @override
  void dispose() async {
    await _themeController.close();
    await _visibilityController.close();
    await _deckController.close();
    await _chosenDeckController.close();
  }
}