import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:w_health/Views/login.dart';
import 'package:flutter/services.dart';

void main() {
    SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFFAFAFA),
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark 
    ),
  );
  runApp(const Whealth());
}

class Whealth extends  StatelessWidget {
  const Whealth({ Key? key }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "W-Health",
      theme: ThemeData(
        fontFamily: 'Nunito',

        colorScheme: _customColorScheme,
        ),
      home: const LoaderOverlay(child: SafeArea( child: Login()))
    );
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