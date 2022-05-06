import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:w_health/Controllers/userController.dart';
import 'package:w_health/Elements/user.dart';
import 'package:w_health/Views/totalEmployees.dart';

class Supervisor extends StatefulWidget {
  final UserSupervisor user;
  const Supervisor(this.user, {Key? key}) : super(key: key);

  @override
  State<Supervisor> createState() => _Supervisor();
}

class _Supervisor extends State<Supervisor> {
  Map<String, dynamic> totalEmployeesList = {};
  String totalEmployees = '';
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getTotalemployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loading
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
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
        GestureDetector(
          onTap: () {
            loadTotalEmployeesView();
          },
          child: Row(
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
    http.post(Uri.parse(
        'https://w-health-backend.herokuapp.com/api/users/lastSurvey/' +
            widget.user.email));
  }

  void logOut() async{
     final prefs = await SharedPreferences.getInstance();
      prefs.remove("user");
    Navigator.pop(context);
  }

  void getTotalemployees() async {
    Map<String, dynamic>? storedEmployees = await UserController.getTotalEmployeesLocal(widget.user.coorporation);
    if(storedEmployees == null)
    {
      if (!await InternetConnectionChecker().hasConnection) {
      setState(() {
        totalEmployees = "do not tap";
        loading = false;
      });
      showSnackBar("There is no internet connection and no cached data, please check your connection before proceding");
    } else {
      UserController.getTotalEmployees(widget.user.coorporation, this);
    }
    }
    else{
      if (!await InternetConnectionChecker().hasConnection) {
      setTotalEmployees(storedEmployees);
      showSnackBar("There is no internet connection but cached data, data might be unupdated.");
    } else {
      setTotalEmployees(storedEmployees);
      UserController.getTotalEmployees(widget.user.coorporation, this);
    }

    }
    
   
  }

  void setTotalEmployees(pEmployees) {
    setState(() {
      totalEmployeesList = pEmployees;
      totalEmployees = pEmployees['users'].length.toString();
      loading = false;
    });
  }

  void loadTotalEmployeesView() {
    //context.loaderOverlay.show();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TotalEmployees(totalEmployeesList)));
    //context.loaderOverlay.hide();
  }

  void showSnackBar(String message) {
    context.loaderOverlay.hide();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
