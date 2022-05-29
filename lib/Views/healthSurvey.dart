import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HealthSurvey extends StatefulWidget {
  const HealthSurvey({Key? key}) : super (key:key);

  @override
  State<HealthSurvey> createState() => _HealthSurvey();
}

class _HealthSurvey extends State<HealthSurvey> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool enabled = true;
  var listener;

  String _stressLvl = "";
  String _jobDifficulty = "";
  String _schRespected = "";
  String _sympthoms = "";
  String _comments = "";


  @override
  void initState() {
    super.initState();
    listener = checkConnection(); 
  }

  Widget _buildComments() {
    return TextFormField(
      decoration: const InputDecoration(
            labelText: "Comments",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          validator: (value) {
            if(value!.isEmpty){
              return 'Comments are required';
            }
          },
          onSaved: (value) {
        _comments = value!;
      }
    );
  }

  Widget _buildSchRespected() {
    return TextFormField(
      decoration: const InputDecoration(
            labelText: "Was the schedule respected?",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          validator: (value) {
            if(value!.isEmpty){
              return 'Answer is required';
            }
            if(!RegExp("^Yes|No").hasMatch(value)){
              return 'Please enter a valid answer';
            }
          },
          onSaved: (value) {
        _schRespected = value!;
      }
    );
  }

   Widget _buildSympthoms() {
    return TextFormField(
      decoration: const InputDecoration(
            labelText: "Are there sympthoms?",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
          validator: (value) {
            if(value!.isEmpty){
              return 'Answer is required';
            }
            if(!RegExp("^Yes|No").hasMatch(value)){
              return 'Please enter a valid answer';
            }
          },
          onSaved: (value) {
        _sympthoms = value!;
      }
    );
  }
  
  Widget _buildStreesLvl() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Stress Level From 1 to 5'),
      keyboardType: TextInputType.number,
      validator: (value) {
        int? num = int.tryParse(value!);

        if (num == null || num <= 0) {
          return 'Stress must be greater than 0';
        }

        if (num > 5) {
          return 'Stress must be lower than 5';
        }


        return null;
      },
      onSaved: (value) {
        _stressLvl = value!;
      },
    );
  }

  Widget _buildJobDifficulty() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Job Difficulty From 1 to 5'),
      keyboardType: TextInputType.number,

      validator: (value) {
        int? num = int.tryParse(value!);

        if (num == null || num <= 0) {
          return 'Stress must be greater than 0';
        }

        if (num > 5) {
          return 'Stress must be lower than 5';
        }


        return null;
      },
      onSaved: (value) {
        _jobDifficulty = value!;
      },
    );
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Health Survey")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildStreesLvl(),
                const SizedBox(
                  height: 30,
                ),
                _buildJobDifficulty(),
                const SizedBox(
                  height: 30,
                ),
                _buildSchRespected(),
                const SizedBox(
                  height: 30,
                ),
                _buildSympthoms(),
                const SizedBox(
                  height: 30,
                ),
                _buildComments(),
                SizedBox(height: 100),
                RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    _formKey.currentState!.save();


                    //aqui
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  StreamSubscription<InternetConnectionStatus> checkConnection() {
    InternetConnectionChecker().checkInterval = const Duration(seconds: 3);
    return InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          setState(() {
            enabled = true;
          });
          showSnackBar("There is internet connection");
          break;
        case InternetConnectionStatus.disconnected:
          setState(() {
            enabled = false;
          });
          showSnackBar("There is no internet connection");
          break;
      }
    });
  }

  // void send() async{
  //  if (!await InternetConnectionChecker().hasConnection) {
  //     showSnackBar("Please check your connection");
  //     return;
  //   }

  //    hs =

  // }
}