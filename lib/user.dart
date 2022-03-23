abstract class User{

  late String name;
  late String email;
  late String coorporation;
  late String isSupervisor;

  User(Map<String, dynamic> data);

}

class UserSupervisor extends User{
  
  late num timesCheckedSurveys;

   UserSupervisor(Map<String, dynamic> data) : super(data){
    timesCheckedSurveys = data['surveyAmmount'];
    super.name = data['name'];
    super.email = data['email'];
    super.coorporation = data['coorporation'];
    super.isSupervisor = data['isSupervisor'];
  }
  
}

class UserEmployee extends User{
  
  late num activeBreakCount;
  late num pExcerciseCount;
  late num healthSurveyCount;

  UserEmployee(Map<String, dynamic> data) : super(data){
    activeBreakCount = data['activeBreakCount'];
    pExcerciseCount = data['pExcerciseCount'];
    healthSurveyCount = data['healthSurveyCount'];
    super.name = data['name'];
    super.email = data['email'];
    super.coorporation = data['coorporation'];
    super.isSupervisor = data['isSupervisor'];
  }

}