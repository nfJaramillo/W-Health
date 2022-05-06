import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/UserController.dart';
import 'package:w_health/Elements/user.dart';
import 'package:http/http.dart' as http;
import 'package:localstore/localstore.dart';

class ModelUser {
  static User? user;
  static final db = Localstore.instance;
  static const id="1a8wn3aw1";

  static String backendUri =
      "https://w-health-backend.herokuapp.com/api/users/";

  static void logIn(String username, String password, bool isReLogin) {
    if (isReLogin) {
      String uri = backendUri + 'email/' + username;
      try {
        http.get(Uri.parse(uri)).then((response) => auth(response));
      } catch (e) {
        rethrow;
      }
    } else {
      if (username.isEmpty || password.isEmpty) {
        throw ('Please do not leave the email or password empty');
      } else {
        String uri = backendUri + 'auth/' + username + '/' + password;
        try {
          http.get(Uri.parse(uri)).then((response) => auth(response));
        } catch (e) {
          rethrow;
        }
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
          storeUserData(userSuper, true);
          UserController.authtenticated(user);
        } else {
          var userEmplo = UserEmployee(userData);
          user = userEmplo;
          storeUserData(userEmplo, false);
          UserController.authtenticated(user);
        }
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      UserController.showSnackBarLogin('Backend server error');
    }
  }

  static void storeUserData(User pUser, bool isSupervisor) async {
    final prefs = await SharedPreferences.getInstance();
    if (isSupervisor) {
      pUser = pUser as UserSupervisor;
      prefs.setString('user', json.encode(pUser.toJson()));
    } else {
      pUser = pUser as UserEmployee;
      prefs.setString('user', json.encode(pUser.toJson()));
    }
  }

  static void getTotalEmployees(String coorporation, superv) {
    String uri = 'https://w-health-backend.herokuapp.com/api/users/corpo/' +
        coorporation;
    http
        .get(Uri.parse(uri))
        .then((response) => getTotalEmployeesResponse(response, superv,coorporation));
  }

  static Future<void> getTotalEmployeesResponse(response, superv,coorporation)  async {
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      if (response.body.isNotEmpty) {
        Map<String, dynamic> employees = jsonDecode(response.body);
        db.collection(coorporation).doc(id).set(employees);
        superv.setTotalEmployees(employees);
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw ("Backend server error");
    }
  }

  static Future<Map<String, dynamic>?> getTotalEmployeesLocal(coorporation) async {
        return await db.collection(coorporation).doc(id).get();
  }
}
