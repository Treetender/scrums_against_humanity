import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc extends Bloc {

  bool _visibility = false;
  final _settingsController = BehaviorSubject<bool>.seeded(false);

  SettingsBloc() {
    _settingsController.sink.add(_visibility);
  }

  bool get selectedVisibility => _visibility;
  ValueStream<bool> get visibilityStream => _settingsController.stream;

  void toggleVisibility(bool visible) {
    _visibility = visible;
    _settingsController.sink.add(visible);
  }

  @override
  void dispose() async {
    await _settingsController.close();
  }
}