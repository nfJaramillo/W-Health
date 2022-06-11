import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_health/Models/preferences.dart';
import 'package:w_health/Elements/preferences_service.dart';

class PreferencesB extends Cubit<Preferences>{
  final PreferencesService _service;

  PreferencesB(
    this._service,
    Preferences initialState,
  ) : super(initialState);

  Future<void> changePreferences(Preferences preferences) async {
    await _service.set(preferences);
    emit(preferences);
  }

  Future<void> deleteAllPreferences () async {
    await _service.clear();
    emit(Preferences.defaultValues());
  }

}