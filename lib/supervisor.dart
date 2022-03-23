
import 'package:flutter/material.dart';


class Supervisor extends StatefulWidget {
  const Supervisor({Key? key}) : super(key: key);

  @override
  State<Supervisor> createState() => _Supervisor();
}


class _Supervisor extends State<Supervisor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[supervisorStructure()],
      ),
    ));
  }

  Column supervisorStructure() {
    return Column(
      children: const  <Widget>[
          Text(
          "Supervisor",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 50),
        ),
        
      ],
    );
  }
}
