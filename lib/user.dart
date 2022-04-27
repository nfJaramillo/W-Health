import 'package:flutter/cupertino.dart';

abstract class User{
  @protected
  late String name;
  late String email;
  late String coorporation;
  late String isSupervisor;

  User(Map<String, dynamic> data);
}

class UserSupervisor extends User{
  
  late String lastSurvey;

   UserSupervisor(Map<String, dynamic> data) : super(data){
    lastSurvey = data['lastSurvey'];
    super.name = data['name'];
    super.email = data['email'];
    super.coorporation = data['coorporation'];
    super.isSupervisor = data['isSupervisor'];
  }
  
}

class UserEmployee extends User{
  
  late String lastActiveBreak;
  late String lastP_Exercise;
  late String lastE_Survey;

  UserEmployee(Map<String, dynamic> data) : super(data){
    lastActiveBreak = data['lastActiveBreak'];
    lastP_Exercise = data['lastP_Exercise'];
    lastE_Survey = data['lastE_Survey'];
    super.name = data['name'];
    super.email = data['email'];
    super.coorporation = data['coorporation'];
    super.isSupervisor = data['isSupervisor'];
  }

}