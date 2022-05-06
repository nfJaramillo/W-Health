import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_health/Elements/preferences_bloc.dart';
import 'package:w_health/Models/preferences.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return BlocBuilder<PreferencesB, Preferences>(
      builder: (context, preferences){
        return Scaffold(
          appBar: AppBar(
            title: Text("Settings"),
            automaticallyImplyLeading: true,
          ),
        body: ListView(
          children: [
            _buildThemeSelect(preferences, context),
          ],
        ),
      );
    },
    );
  }

  Widget _buildThemeSelect(Preferences preferences, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            RadioListTile<ThemeMode>(
              title: Text("Dark Mode"),
              value: ThemeMode.dark, 
              groupValue: preferences.themeMode, 
              onChanged: (s) {
                context.read<PreferencesB>().changePreferences(
                  preferences.copyWith(themeMode: ThemeMode.dark)
                );
              }
              ),
            RadioListTile<ThemeMode>(
              title: Text("Light Mode"),
              value: ThemeMode.light, 
              groupValue: preferences.themeMode, 
              onChanged: (s) {
                context.read<PreferencesB>().changePreferences(
                  preferences.copyWith(themeMode: ThemeMode.light)
                );
              }
              ),
            RadioListTile<ThemeMode>(
              title: Text("System"),
              value: ThemeMode.system, 
              groupValue: preferences.themeMode, 
              onChanged: (s) {
                context.read<PreferencesB>().changePreferences(
                  preferences.copyWith(themeMode: ThemeMode.system)
                );
              }
              ),
          ],
        ),
      ),
      );
  }


}

