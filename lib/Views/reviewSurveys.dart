import 'package:flutter/material.dart';
import 'package:w_health/Controllers/userController.dart';
import 'surveyDetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ReviewSurveys extends StatefulWidget {
  final Map<String, dynamic> surveyList;
  const ReviewSurveys(this.surveyList, {Key? key}) : super(key: key);

  @override
  State<ReviewSurveys> createState() => _ReviewSurveys();
}

class _ReviewSurveys extends State<ReviewSurveys> {
  var surveys;

  @override
    void initState() {
      super.initState();
      surveys = widget.surveyList;
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: RefreshIndicator(onRefresh: refresh, child: totalEmployeesStructure())  ),
        bottomNavigationBar: Container(
          height: 60,
          color: Colors.black12,
          child: InkWell(
            onTap: () => logOut(),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.logout,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const Text('Back'),
                ],
              ),
            ),
          ),
        ));
  }

  ListView totalEmployeesStructure() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: surveys['surveys'].length,
      itemBuilder: (context, index) {
        return Column(children: [
          if (index == 0)
            ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                ),
                title: Row(
                  children: const [
                    Expanded(child: Text("DATE")),
                    Expanded(child: Text("NAME")),
                  ],
                )),
          ListTile(
            leading: const Icon(
              Icons.pending_actions,
              color: Color(0xFF7086B2),
              size: 36.0,
            ),
            title: Row(
              children: [
                Expanded(
                    child: Text(
                        transformDate(surveys['surveys'][index]["date"]))),
                Expanded(
                    child: Text(
                        surveys['surveys'][index]["name"])),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SurveyDetail(surveys['surveys'][index]),
                ),
              ).then((value) => refresh());
            },
          )
        ]);
      },
    );
  }

  void logOut() {
    Navigator.pop(context);
  }

   String transformDate(pDate) {
    String ans = "";
    DateTime dt = DateTime.parse(pDate).toLocal();
    ans = dt.day.toString() +
        "/" +
        dt.month.toString() +
        "/" +
        dt.year.toString();
    return ans;
  }

  Future refresh() async {
     if (!await InternetConnectionChecker().hasConnection) {
      showSnackBar("Please check your connection");
      return;
    }
     String uri = 'https://w-health-backend.herokuapp.com/api/surveys/';
    http.get(Uri.parse(uri)).then((response) => update(response));
  }

   update(response){
     if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      if (response.body.isNotEmpty) {
        Map<String, dynamic> surveysList = jsonDecode(response.body);
        setState(() {
      surveys = surveysList;
    });
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw ("Backend server error");
    }
}
    void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
  }

 
