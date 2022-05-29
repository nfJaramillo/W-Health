import 'dart:convert';
import 'dart:io';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;

class SurveyDetail extends StatefulWidget {
  final Map<String, dynamic> employeeData;
  const SurveyDetail(this.employeeData, {Key? key}) : super(key: key);

  @override
  State<SurveyDetail> createState() => _SurveyDetail();
}

class _SurveyDetail extends State<SurveyDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: <Widget>[employeeDetailStructure()],
            ),
          ),
        ),
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

  Column employeeDetailStructure() {
    return Column(
      children: <Widget>[
        const Text(
          "Employee Health Survey",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Email: " + widget.employeeData["email"],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Name: " + widget.employeeData["name"],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Estress level: ",
          textAlign: TextAlign.center,
          style:  TextStyle(fontSize: 20),
        ),
       RatingBarIndicator(
          rating: widget.employeeData["stressLevel"].toDouble(),
          itemBuilder: (context, index) => const Icon(
              Icons.circle,
              color: Color(0xFF7086B2),
          ),
          itemCount: 5,
          itemSize: 40.0,
          direction: Axis.horizontal,
      ),
      const SizedBox(
          height: 20,
        ),
        const Text(
          "Job difficulty:",
          textAlign: TextAlign.center,
          style:  TextStyle(fontSize: 20),
        ),
       RatingBarIndicator(
          rating:  widget.employeeData["workHard"].toDouble(),
          itemBuilder: (context, index) => const Icon(
              Icons.circle,
              color: Color(0xFF7086B2),
          ),
          itemCount: 5,
          itemSize: 40.0,
          direction: Axis.horizontal,
      ),
      const SizedBox(
              height: 20,
            ),
            const Text(
              "was the schedule respected?",
              textAlign: TextAlign.center,
              style:  TextStyle(fontSize: 20),
            ),
            iconForBooleans(widget.employeeData["hoursRespected"]),

             const SizedBox(
              height: 20,
            ),
            const Text(
              "Are there symptoms?",
              textAlign: TextAlign.center,
              style:  TextStyle(fontSize: 20),
            ),
            iconForBooleans(widget.employeeData["symthoms"]),

             const SizedBox(
              height: 20,
            ),
            const Text(
              "Comments:",
              textAlign: TextAlign.center,
              style:  TextStyle(fontSize: 20),
            ),
            Text(
              widget.employeeData["comments"],
              textAlign: TextAlign.center,
              style:  TextStyle(fontSize: 20),
            ),

            const SizedBox(
              height: 20,
            ),
            
          ElevatedButton(
          child: const Text("Mark as reviewed"),
          onPressed: () => {reviewSurvey()},
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            primary: Theme.of(context).colorScheme.primary,
            minimumSize: const Size.fromHeight(50),
          ),
        ),

         const SizedBox(
              height: 20,
            ),
      ],
    );
  }

  String lastActiveBreak(pLast) {
    String ans = "";
    DateTime dt = DateTime.parse(widget.employeeData["lastActiveBreak"]).toLocal();
    ans = dt.day.toString() +
        "/" +
        dt.month.toString() +
        "/" +
        dt.year.toString() +
        " ";
    ans = ans + dt.hour.toString() + ":" + dt.minute.toString();
    return ans;
  }

  void logOut() {
    Navigator.pop(context);
  }

  Icon iconForBooleans(pBoolean){
    if(pBoolean){
              return const Icon(
              Icons.check_circle,
              color: Color(0xFF7086B2),
              size: 50.0,
            );
     }
     else{
        return const Icon(
              Icons.cancel,
              color: Color.fromARGB(255, 210, 62, 8),
              size: 50.0,
            );
     }
  }

  void reviewSurvey() async{

     if (!await InternetConnectionChecker().hasConnection) {
      showSnackBar("Please check your connection");
      return;
    }

     final data = json.encode({'reviewed': true});
     final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

  var url = Uri.parse('https://w-health-backend.herokuapp.com/api/surveys/' + widget.employeeData["_id"]);
  await http.put(url, headers: headers, body: data);
  showSnackBar ("Marked as reviewed");
  Navigator.pop(context);
  }

      void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
