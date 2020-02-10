import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBloc extends Bloc {

  bool _visibility = false;
  final _settingsController = BehaviorSubject<bool>.seeded(false);
  final hiddenOnSelectSettingsKey = "hiddenOnSelect";

  SettingsBloc() {
    _settingsController.sink.add(_visibility);
    SharedPreferences.getInstance()
      .then((value) => _settingsController.sink.add(value.getBool(hiddenOnSelectSettingsKey) ?? false));
  }

  bool get selectedVisibility => _visibility;
  ValueStream<bool> get visibilityStream => _settingsController.stream;

  void toggleVisibility(bool visible) {
    _visibility = visible;
    _settingsController.sink.add(visible);
    SharedPreferences.getInstance()
      .then((value) => value.setBool(hiddenOnSelectSettingsKey, visible));
  }

  @override
  void dispose() async {
    await _settingsController.close();
  }
}