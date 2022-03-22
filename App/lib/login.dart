import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    TextEditingController emailController = new TextEditingController();
    TextEditingController pswController = new TextEditingController();
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
                    decoration: TextDecoration.underline,
                    decorationColor: Theme.of(context).colorScheme.primary,
                  )),
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

  void authenticate(String username, String password) async {
    String uri = 'http://10.0.2.2:3000/api/users/'+username+'/'+password;
    print(uri);
    final response = await http
        .get(Uri.parse(uri));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print("Backend server error");
    }
  }
}
