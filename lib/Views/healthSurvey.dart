import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class HealthSurvey extends StatefulWidget {

  final Map<String, dynamic> employeeData;
  const HealthSurvey(this.employeeData, {Key? key}) : super (key:key);
  @override
  State<HealthSurvey> createState() => _HealthSurvey();
}

class _HealthSurvey extends State<HealthSurvey> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SharedPreferences prefs;
  bool enabled = true;
  var listener;

  String _stressLvl = "";
  String _jobDifficulty = "";
  String _schRespected = "";
  String _sympthoms = "";
  String _comments = "";


  getSharedPreferences () async
  {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
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
                  height: 20,
                ),
                _buildJobDifficulty(),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "For the following two questions answer: 'Yes' or 'No'",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,)
                ),
                const SizedBox(
                  height: 50,
                ),
                _buildSchRespected(),
                const SizedBox(
                  height: 20,
                ),
                _buildSympthoms(),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "-----------------------------------------",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,)
                ),
                _buildComments(),
                SizedBox(height: 100),
                RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    saveValuesInPrefs();
                    if (!await InternetConnectionChecker().hasConnection) {
                        showSnackBar("Please check your connection");
                        return;
                        }
                    send();
                    showSnackBar ("Data was saved succesfully.");
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



  saveValuesInPrefs () async
  {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("stressLvl", _stressLvl);
    prefs.setString("jobDifficulty", _jobDifficulty);
    prefs.setString("schRespected", _schRespected);
    prefs.setString("sympthoms", _sympthoms);
    prefs.setString("comments", _comments);
  }

  void send() async{
      final data = json.encode({'survey': true});
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

  var url = Uri.parse('https://w-health-backend.herokuapp.com/api/surveys/' + widget.employeeData["_id"]);
  await http.put(url, headers: headers, body: data);
  Navigator.pop(context);
    
  }
}