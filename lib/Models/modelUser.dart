import 'dart:convert';
import '../Controllers/UserController.dart';
import 'package:w_health/Elements/user.dart';
import 'package:http/http.dart' as http;

class ModelUser {
  static User? user;

  static String backendUri =
      "https://w-health-backend.herokuapp.com/api/users/";

  static void logIn(String username, String password) {
    if (username.isEmpty || password.isEmpty) {
      throw ('Please do not leave the email or password empty');
    } else {
      String uri = backendUri + 'auth/' + username + '/' + password;

      try{
        http.get(Uri.parse(uri)).then((response) => auth(response));
      }
      catch(e){
        rethrow;
      }
      

    }
  }

  static void auth(response) {
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      if (response.body.isEmpty) {
        UserController.showSnackBarLogin('Wrong username or password');
      } else {
        Map<String, dynamic> userData = jsonDecode(response.body);
        var userSuper = UserSupervisor(userData);
        if (userSuper.isSupervisor == 'yes') {
          user = userSuper;
          UserController.authtenticated(user);
        } else {
          var userEmplo = UserEmployee(userData);
          user = userEmplo;
          UserController.authtenticated(user);
        }
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      UserController.showSnackBarLogin('Backend server error');
    }
  }
}
