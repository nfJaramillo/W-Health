import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:w_health/Views/login.dart';
import 'package:w_health/Elements/preferences_service.dart';
import 'package:w_health/Elements/preferences_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_health/Models/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Whealth());
}

class Whealth extends  StatelessWidget {
  const Whealth({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PreferencesB>(
      future: buildBloc(),
      builder: (context, blocSnapshot){
        if(blocSnapshot.hasData && blocSnapshot.data != null){
          return BlocProvider<PreferencesB>(
            create: (_) => blocSnapshot.data!,
            child: BlocBuilder<PreferencesB, Preferences>(
              builder: (context, preferences){
                return  MaterialApp(
                  title: "W-Health",
                  theme: ThemeData(
                  fontFamily: 'Nunito',
                  colorScheme: _customColorScheme,
                  ),
                  darkTheme: ThemeData.dark(),
                  themeMode: preferences.themeMode ,
                  home: const LoaderOverlay(child: Login())
                );
              }, 
            ),
          );
        }

        return SizedBox.shrink();
      });
    }




  Future<PreferencesB> buildBloc() async{
    final prefs = await SharedPreferences.getInstance();
    final service = MyPreferencesService(prefs);
    return PreferencesB(service, await service.get());
  }
}


const ColorScheme _customColorScheme = ColorScheme(
  primary: Color(0xFF7086B2),
  primaryVariant:  Color(0xFF454545),
  secondary:  Color(0xFF02C39A),
  secondaryVariant:  Color(0xFFF17105),
  surface: Color(0xFF454545),
  background: Color(0xFFF4F4F4),
  error: Colors.red,
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onSurface: Colors.white,
  onBackground: Colors.black,
  onError: Colors.white,
  brightness: Brightness.light,
);
