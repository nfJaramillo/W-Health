import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:w_health/Elements/user.dart';

class Supervisor extends StatefulWidget {
  final UserSupervisor user;
  const Supervisor(this.user, {Key? key}) : super(key: key);

  @override
  State<Supervisor> createState() => _Supervisor();
}

class _Supervisor extends State<Supervisor> {
   

  String totalEmployees = '';

  @override
    void initState() {
    super.initState();
     getTotalemployees();
  } 
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: <Widget>[supervisorStructure()],
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
        ));
  }

  Column supervisorStructure() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          "General Data",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40),
        ),
        Divider(
          height: 20,
          thickness: 2,
          indent: 20,
          endIndent: 20,
          color: Theme.of(context).colorScheme.primary,
        ),

        const SizedBox(
          height: 20,
        ),

        // Total employees

        const Text(
          "Total employees",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 50),
            Expanded(
              child: Icon(
                Icons.account_circle,
                color: Theme.of(context).colorScheme.primary,
                size: 40.0,
                semanticLabel: 'Icon for total employees',
              ),
            ),
             Expanded(
              child: Text(
                totalEmployees,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(width: 50),
          ],
        ),

        // Active employees

        const SizedBox(
          height: 20,
        ),

        const Text(
          "Active employees",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 50),
            Expanded(
              child: Icon(
                Icons.groups,
                color: Theme.of(context).colorScheme.primary,
                size: 40.0,
                semanticLabel: 'Icon for active employees',
              ),
            ),
            const Expanded(
              child: Text(
                '3',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(width: 50),
          ],
        ),

        // Offline employees

        const SizedBox(
          height: 20,
        ),

        const Text(
          "Offline employees",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 50),
            Expanded(
              child: Icon(
                Icons.hotel,
                color: Theme.of(context).colorScheme.primary,
                size: 40.0,
                semanticLabel: 'Icon for offline employees',
              ),
            ),
            const Expanded(
              child: Text(
                '1',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(width: 50),
          ],
        ),

        // Sick employees

        const SizedBox(
          height: 20,
        ),

        const Text(
          "Sick employees",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),

        const SizedBox(
          height: 15,
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 50),
            Expanded(
              child: Icon(
                Icons.sick,
                color: Theme.of(context).colorScheme.primary,
                size: 40.0,
                semanticLabel: 'Icon for sick employees',
              ),
            ),
            const Expanded(
              child: Text(
                '0',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(width: 50),
          ],
        ),

        const SizedBox(
          height: 50,
        ),

        ElevatedButton(
          child: const Text("Review health surveys"),
          onPressed: () => {reviewHealthSurveys()},
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            primary: Theme.of(context).colorScheme.primary,
            minimumSize: const Size.fromHeight(50),
          ),
        ),
      ],
    );
  }

  void reviewHealthSurveys() {
    http.post( Uri.parse('https://w-health-backend.herokuapp.com/api/users/lastSurvey/'+widget.user.email));
  }

  void logOut(){
    Navigator.pop(context);
  }

  void getTotalemployees() async {
    totalEmployees = "-";
    String uri =
          'https://w-health-backend.herokuapp.com/api/users/corpo/'+widget.user.coorporation;
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.

        
        if (response.body.isNotEmpty) {
           Map<String, dynamic> users = jsonDecode(response.body);
           totalEmployees = users['users'].length.toString();
           setState(() {});
        }
        } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Backend server error')));
      }

  }
}
