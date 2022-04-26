import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:w_health/Views/supervisor.dart';

import '../Controllers/UserController.dart';
import '../Elements/user.dart';
import 'employee.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    UserController.setLoginView(this);

    return Scaffold(
        body: Center(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[loginStructure()],
      ),
    ));
  }

  Column loginStructure() {
    TextEditingController emailController = TextEditingController();
    TextEditingController pswController = TextEditingController();
    return Column(
      children: <Widget>[
        const Text(
          "Login",
          style: TextStyle(fontSize: 50),
        ),
        const SizedBox(
          height: 20,
        ),
        Text.rich(
          TextSpan(
            text: "Don't have an account? ",
            style: const TextStyle(fontSize: 20),
            children: <TextSpan>[
              TextSpan(
                  text: 'Sing Up here',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Theme.of(context).colorScheme.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()),
                      );
                    }),
            ],
          ),
        ),
        const SizedBox(
          height: 60,
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
          height: 60,
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
          height: 60,
        ),
        ElevatedButton(
          child: const Text("Log in"),
          onPressed: () =>
              {authenticate(emailController.text, pswController.text)},
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            primary: Theme.of(context).colorScheme.primary,
            minimumSize: const Size.fromHeight(50),
          ),
        ),
      ],
    );
  }

  void authenticate(String username, String password) {
    try {
      UserController.logIn(username, password);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void authtenticated(User pUser) {
    if (pUser.isSupervisor == 'yes') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Supervisor( pUser as UserSupervisor)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Employee(pUser as UserEmployee)),
      );
    }
  }
}
