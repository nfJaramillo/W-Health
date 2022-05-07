import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loader_overlay/loader_overlay.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _Register();
}

enum supervisor { yes, no, empty }
supervisor _selected = supervisor.empty;
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController pswController = TextEditingController();
TextEditingController corpoController = TextEditingController();

class _Register extends State<Register> {
  bool enabled = true;
  var listener;

  @override
  void initState() {
    super.initState();
    
    listener = checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[registerStructure()],
      ),
    ));
  }

  Column registerStructure() {
    return Column(
      children: <Widget>[
        const Text(
          "Create new Account",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 50),
        ),
        const SizedBox(
          height: 20,
        ),
        Text.rich(
          TextSpan(
            text: "Already registered? ",
            style: const TextStyle(fontSize: 20),
            children: <TextSpan>[
              TextSpan(
                  text: 'Log in here',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Theme.of(context).colorScheme.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pop(context);
                    },
                  ),
                  
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: "Name",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: "Email",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          controller: pswController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          controller: corpoController,
          decoration: const InputDecoration(
            labelText: "Corporation",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),
        const SizedBox(
          height: 30,
        ),

        // Radio buttons question

        const Text(
          "Are you a supervisor?",
          style: TextStyle(fontSize: 20),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 50),
            Flexible(
              child: ListTile(
                title: const Text("Yes"),
                horizontalTitleGap: 0,
                leading: Radio<supervisor>(
                  value: supervisor.yes,
                  groupValue: _selected,
                  onChanged: (supervisor? value) {
                    setState(() {
                      _selected = value ?? _selected;
                    });
                  },
                ),
              ),
            ),
            Flexible(
              child: ListTile(
                title: const Text("No"),
                horizontalTitleGap: 0,
                leading: Radio<supervisor>(
                  value: supervisor.no,
                  groupValue: _selected,
                  onChanged: (supervisor? value) {
                    setState(() {
                      _selected = value ?? _selected;
                    });
                  },
                ),
              ),
            ),
          ],
        ),

        ElevatedButton(
          child: const Text("Sing up"),
          onPressed: () => { enabled ?
            register(nameController.text, emailController.text,
                pswController.text, corpoController.text, _selected.name)
                : null
          },
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            primary: enabled ? Theme.of(context).colorScheme.primary : Colors.grey,
            minimumSize: const Size.fromHeight(50),
          ),
        ),
         const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  void register(String name, String email, String password, String corporation,
      String isSupervisor) async {
    
    if (!await InternetConnectionChecker().hasConnection) {
      showSnackBar("Please check your connection");
      return;
         }

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        corporation.isEmpty ||
        isSupervisor == supervisor.empty.name) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields')));
    } else {

       String uri =
          'https://w-health-backend.herokuapp.com/api/users/email/'+ email;
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.

        
        if (response.body.isNotEmpty) {

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('There is already a user registered with that email')));
  
        }
        else{

          http.post(
        Uri.parse('https://w-health-backend.herokuapp.com/api/users/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'corporation': corporation,
          'isSupervisor': isSupervisor,
          'lastSurvey':  "",
          'lastActiveBreak': "",
          'lastP_Exercise': "",
          'lastE_Survey': ""

        }),
      );
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sing up was successful')));
      Navigator.pop(context);

        }
        } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Backend server error')));
      }

    }
  }

  StreamSubscription<InternetConnectionStatus> checkConnection() {
  
    InternetConnectionChecker().checkInterval = const Duration(seconds: 3);
    return InternetConnectionChecker().onStatusChange.listen((status) {
  
      switch (status) {
        case InternetConnectionStatus.connected:
        try{
          setState(() {
            enabled = true;
          });
        }
        catch(e)
        {}
          break;
        case InternetConnectionStatus.disconnected:
        try{
          setState(() {
            enabled = false;
          });
        }
        catch(e){}
          break;
      }
    });
  }

  void showSnackBar(String message) {
    context.loaderOverlay.hide();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
