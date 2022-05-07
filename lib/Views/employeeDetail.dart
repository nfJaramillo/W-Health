import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instant/instant.dart';

class EmployeeDetail extends StatefulWidget {
  final Map<String, dynamic> employeeData;
  const EmployeeDetail(this.employeeData, {Key? key}) : super(key: key);

  @override
  State<EmployeeDetail> createState() => _EmployeeDetail();
}

class _EmployeeDetail extends State<EmployeeDetail> {
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
          "Employee detail",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40),
        ),
        const SizedBox(
          height: 20,
        ),
        CachedNetworkImage(
          imageUrl: widget.employeeData["profilePic"],
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: 120,
            backgroundImage: imageProvider,
          ),
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
        Text(
          "Last active break: " +
              (widget.employeeData["lastActiveBreak"] != ""
                  ? lastActiveBreak(widget.employeeData["lastActiveBreak"])
                  : "The user has never made active breaks"),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
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
}
