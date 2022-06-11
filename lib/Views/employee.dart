import 'package:flutter/material.dart';
import 'package:w_health/Views/healthsurvey.dart';
import 'package:w_health/Views/personalized.dart';
import 'package:w_health/Views/active_break.dart';
import 'package:w_health/Elements/user.dart';
import 'package:http/http.dart' as http;

import 'package:w_health/Views/settings.dart';



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
          leading: const Icon(Icons.menu),
          actions: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {goSettings();},
              ),
          ],
        ),
        body: ListView(
          children: <Widget>[ Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[employeeStructure()],
          )]
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
            style: const TextStyle(fontSize: 50),
          ),
          const SizedBox(height: 30),
         Icon(
                Icons.groups,
                color: Theme.of(context).colorScheme.primary,
                size: 200.0,
                semanticLabel: 'Icon for active employees',
              ),
          const SizedBox(height: 30),
          Text(
              'You should take an active break in ' + calculateTime().toString() + ' minutes',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          const SizedBox(height: 30),
          MaterialButton(
            elevation: 10.0,
            minWidth: 360.0,
            height: 60.0,
            color: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            onPressed: () { lastActiveBreakTime(); },
            child: const Text(
              'Do Active Break',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold 
              ),
            ),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            elevation: 10.0,
            minWidth: 360.0,
            height: 60.0,
            color: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            onPressed: () { lastPersonalizedExercise(); },
            child: const Text(
              'Personalized Exercise',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold 
              ),
            ),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            elevation: 10.0,
            minWidth: 360.0,
            height: 60.0,
            color: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            onPressed: () { lastHealthSurvey(); },
            child: const Text(
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

  void goSettings(){
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => SettingsScreen())
      );
  }

  void goHealthSurvey(){
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => HealthSurvey(widget.user.toJson()))
      );
  }
  void goActiveBreak(){
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) =>  ActiveBreak())
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
              goActiveBreak();
            },
          ),
        ],
      );
    },
  );
}

  

  void lastActiveBreakTime(){
    http.post(Uri.parse('https://w-health-backend.herokuapp.com/api/users/lastActiveBreak/'+widget.user.email));
    _showMyDialog();
  }

  void lastPersonalizedExercise(){
    http.post(Uri.parse('https://w-health-backend.herokuapp.com/api/users/lastP_Exercise/'+widget.user.email));
    goPersonalized();
  }

  void lastHealthSurvey(){
    http.post(Uri.parse('https://w-health-backend.herokuapp.com/api/users/lastE_Survey/'+widget.user.email));
    goHealthSurvey();
  }

  
}