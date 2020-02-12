import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBloc extends Bloc {

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

  bool _visibility = false;
  final _visibilityController = BehaviorSubject<bool>.seeded(false);
  final _themeController = BehaviorSubject<ThemeData>();
  final hiddenOnSelectSettingsKey = "hiddenOnSelect";
  final themeSettingKey = "activeTheme";

  SettingsBloc() {
    _visibilityController.sink.add(_visibility);
    _themeController.sink.add(lightTheme);
    SharedPreferences.getInstance()
      .then((value) => _visibilityController.sink.add(value.getBool(hiddenOnSelectSettingsKey) ?? false));
    SharedPreferences.getInstance()
      .then((value) => _themeController.sink.add(value.get(themeSettingKey) ?? false));
    
  }

  bool get selectedVisibility => _visibility;
  ValueStream<bool> get visibilityStream => _visibilityController.stream;

  void toggleVisibility(bool visible) {
    _visibility = visible;
    _visibilityController.sink.add(visible);
    SharedPreferences.getInstance()
      .then((value) => value.setBool(hiddenOnSelectSettingsKey, visible));
  }

  @override
  void dispose() async {
    await _themeController.close();
    await _visibilityController.close();
  }
}