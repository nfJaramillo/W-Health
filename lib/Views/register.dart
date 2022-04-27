import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
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
          onPressed: () => {
            register(nameController.text, emailController.text,
                pswController.text, corpoController.text, _selected.name)
          },
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            primary: Theme.of(context).colorScheme.primary,
            minimumSize: const Size.fromHeight(50),
          ),
        ),
      ],
    );
  }

  void register(String name, String email, String password, String corporation,
      String isSupervisor) async {
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
}
