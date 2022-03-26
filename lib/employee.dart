
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:w_health/personalized.dart';
import 'package:w_health/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart'; 


class Employee extends StatefulWidget {

  final UserEmployee user;
  
  const Employee(this.user, {Key? key}) : super(key: key);
 
  

  @override 
  State<Employee> createState() => _Employee();
  }


class _Employee extends State<Employee> {
  
  String name = '';
  String lastActivePause = '';

  @override
    void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            Icon(Icons.more_vert),
          ],
        ),
        body: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[employeeStructure()],
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          color: Colors.black12,
          child: InkWell(
            onTap: () => logOut(),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.logout,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const Text('Logout'),
                ],
              ),
            ),
          ),
        )
    );
  }

  Column employeeStructure() {
    return Column(
      
      children: <Widget>[
          Text(
            widget.user.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 50),
          ),
          SizedBox(height: 30),
         Icon(
                Icons.groups,
                color: Theme.of(context).colorScheme.primary,
                size: 200.0,
                semanticLabel: 'Icon for active employees',
              ),
          SizedBox(height: 30),
          Text(
              'You should take an active break in ' + calculateTime().toString() + ' minutes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          SizedBox(height: 30),
          MaterialButton(
            elevation: 10.0,
            minWidth: 360.0,
            height: 60.0,
            color: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            onPressed: () { lastActiveBreakTime(); },
            child: Text(
              'Do Active Break',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold 
              ),
            ),
          ),
          SizedBox(height: 30),
          MaterialButton(
            elevation: 10.0,
            minWidth: 360.0,
            height: 60.0,
            color: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            onPressed: () { lastPersonalizedExercise(); },
            child: Text(
              'Personalized Exercise',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold 
              ),
            ),
          ),
          SizedBox(height: 30),
          MaterialButton(
            elevation: 10.0,
            minWidth: 360.0,
            height: 60.0,
            color: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            onPressed: () { lastHealthSurvey(); },
            child: Text(
              'Health Survey',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold  
              ),
            ),
          )
        
      ],
    );
  }

  void logOut(){
    Navigator.pop(context);
  }

  void goPersonalized(){
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => Personalized())
      );
  }

  int calculateTime() {
    DateTime dateLastBreak = DateTime.parse(widget.user.lastActiveBreak);
    DateTime dateNow = DateTime.now();
    int minSinceLastBreak = 0;
    int breakMinTime = 120;
    int minutesToShow= 120;
    
    if(dateNow.isAfter(dateLastBreak))
    {
      minSinceLastBreak = dateNow.difference(dateLastBreak).inMinutes;
      if (minSinceLastBreak < breakMinTime) {
         minutesToShow = breakMinTime - minSinceLastBreak;
      }
      else {
        
      }

      return minutesToShow;
    }

    else{
      return minutesToShow;
    }
  }

  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('LETS REST', style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('We know you have been working really hard, lets take an active pause.'),
              Text('Remember to check your personalized routines'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Sure',  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  

  void lastActiveBreakTime(){
    http.post(Uri.parse('http://10.0.2.2:3000/api/users/lastActiveBreak/'+widget.user.email));
    _showMyDialog();
  }

  void lastPersonalizedExercise(){
    http.post(Uri.parse('http://10.0.2.2:3000/api/users/lastP_Exercise/'+widget.user.email));
    goPersonalized();
  }

  void lastHealthSurvey(){
    http.post(Uri.parse('http://10.0.2.2:3000/api/users/lastE_Survey/'+widget.user.email));
  }

  
}