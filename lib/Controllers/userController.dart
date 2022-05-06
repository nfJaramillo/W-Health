
import 'package:w_health/Models/modelUser.dart';




class UserController  {

  static var loginView;
  

   static void logIn(String username, String password,  bool isReLogin) {
     try{
       ModelUser.logIn(username,password, isReLogin);
     }
     catch(e){
        rethrow;
     }
    
  }

  static void getTotalEmployees(String coorporation, superv) {
     try{
       ModelUser.getTotalEmployees(coorporation, superv);
     }
     catch(e){
        rethrow;
     }
    
  }

  static void showSnackBarLogin(String message){
    loginView.showSnackBar(message);
  }

  static void setLoginView(pView){
    loginView = pView;
  }

  static void authtenticated(pUser){
    loginView.authtenticated(pUser);
  }

}



 


