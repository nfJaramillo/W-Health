import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:w_health/Views/supervisor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
  bool enabled = true;
  var listener;

  @override
  void initState() {
    super.initState();
    checkIfUserExists();
    listener = checkConnection();
  }



  @override
  Widget build(BuildContext context) {
    UserController.setLoginView(this);
    return Scaffold(
        body: SafeArea(child:Center(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[loginStructure()],
      ),
    ) ),);
  }

  Column loginStructure() {
    TextEditingController emailController = TextEditingController();
    TextEditingController pswController = TextEditingController();
    return Column(
      children: <Widget>[
        CachedNetworkImage(
        imageUrl: "https://i.ibb.co/0MS0WJm/Logo-W-Health.png",
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
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
                    ..onTap = () { enabled?
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()),
                      ).then((value) => listener.resume()) : null;
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
          onPressed: () => {
            enabled
                ? authenticate(emailController.text, pswController.text, false)
                : null
          },
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            primary:
                enabled ? Theme.of(context).colorScheme.primary : Colors.grey,
            minimumSize: const Size.fromHeight(50),
          ),
        ),
      ],
    );
  }

  void checkIfUserExists() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedUser = prefs.getString("user");
    if (savedUser != null) {
      Map<String, dynamic> userData = jsonDecode(savedUser);
      var userSuper = UserSupervisor(userData);
      if (await InternetConnectionChecker().hasConnection) {
        showSnackBar("There is internet connection");
        authenticate(userSuper.email, "", true);
      } else {
        showSnackBar("There is no internet connection");
        if (userSuper.isSupervisor == 'yes') {
          authtenticated(userSuper);
        } else {
          var userEmplo = UserEmployee(userData);
          UserController.authtenticated(userEmplo);
        }
      }
    } else {
      if (!await InternetConnectionChecker().hasConnection) {
        setState(() {
          enabled = false;
        });
        showSnackBar(
            "There is no internet connection and no cached data, please check your connection before proceding");
      }
    }
  }

  StreamSubscription<InternetConnectionStatus> checkConnection() {
    InternetConnectionChecker().checkInterval = const Duration(seconds: 3);
    return InternetConnectionChecker().onStatusChange.listen((status) {
  
      switch (status) {
        case InternetConnectionStatus.connected:
          setState(() {
            enabled = true;
          });
          showSnackBar("There is internet connection");
          break;
        case InternetConnectionStatus.disconnected:
          setState(() {
            enabled = false;
          });
          showSnackBar("There is no internet connection");
          break;
      }
    });
  }

  Future<void> authenticate(String username, String password, bool isReLogin) async {
     if (await InternetConnectionChecker().hasConnection) {
        try {
      context.loaderOverlay.show();
      UserController.logIn(username, password, isReLogin);
    } catch (e) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
     }
     else{
       showSnackBar("Please check your connection");
     }
   
  }

  void showSnackBar(String message) {
    context.loaderOverlay.hide();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void authtenticated(User pUser) {
    context.loaderOverlay.hide();
    if (pUser.isSupervisor == 'yes') {
      listener.pause();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Supervisor(pUser as UserSupervisor)),
      ).then((value) => listener.resume());
    } else {
      listener.pause();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Employee(pUser as UserEmployee)),
      ).then((value) => listener.resume());
    }
  }
}
