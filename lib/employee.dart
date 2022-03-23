
import 'package:flutter/material.dart';


class Employee extends StatefulWidget {
  const Employee({Key? key}) : super(key: key);

  @override
  State<Employee> createState() => _Employee();
}


class _Employee extends State<Employee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[employeeStructure()],
      ),
    ));
  }

  Column employeeStructure() {
    return Column(
      children: const  <Widget>[
          Text(
          "Employee",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 50),
        ),
        
      ],
    );
  }
}
