
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use
import 'dart:io';

import 'package:flutter/material.dart';
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
     getLastActivePause();
     getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          actions: [
            Icon(Icons.favorite),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search),
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
            name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 50),
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
            onPressed: () {  },
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
            onPressed: () {  },
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
            onPressed: () {  },
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

  void getName() async {
    name = "-";
    String uri =
          'http://10.0.2.2:3000/api/users/'+widget.user.name;
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.

        
        if (response.body.isNotEmpty) {
           Map<String, dynamic> users = jsonDecode(response.body);
           name = users['users'].length.toString();
           setState(() {});
        }
        } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Backend server error')));
      }
  }

  void getLastActivePause() async {
    lastActivePause = "-";

    String uri =
          'http://10.0.2.2:3000/api/users/'+widget.user.lastActiveBreak;
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.

        
        if (response.body.isNotEmpty) {
           Map<String, dynamic> users = jsonDecode(response.body);
           lastActivePause = users['users'].length.toString();
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