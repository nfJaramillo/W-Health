import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
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
                  text: 'Sing In here',
                  style: TextStyle(
                    decoration: TextDecoration.underline, decorationColor: Theme.of(context).colorScheme.primary,
                  )),
            ],
          ),
        ),

        const SizedBox(
          height: 60,
        ),

        const TextField(
          decoration: InputDecoration(
            labelText: "Email",
            labelStyle: TextStyle(fontSize: 20),
            filled: true,
          ),
        ),

        const SizedBox(
          height: 60,
        ),

        const TextField(
          decoration: InputDecoration(
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
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            primary: Theme.of(context).colorScheme.primary,
            minimumSize: const Size.fromHeight(50),
          ),
        ),
      ],
    );
  }
}
