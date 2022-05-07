import 'package:flutter/material.dart';

import 'employeeDetail.dart';

class TotalEmployees extends StatefulWidget {
  final Map<String, dynamic> totalEmployeesList;
  const TotalEmployees(this.totalEmployeesList, {Key? key}) : super(key: key);

  @override
  State<TotalEmployees> createState() => _TotalEmployees();
}

class _TotalEmployees extends State<TotalEmployees> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child:totalEmployeesStructure() ),
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
      itemCount: widget.totalEmployeesList['users'].length,
      itemBuilder: (context, index) {
        return Column(children: [
          if (index == 0)
            ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                ),
                title: Row(
                  children: const [
                    Expanded(child: Text("EMAIL")),
                    Expanded(child: Text("NAME")),
                  ],
                )),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(widget.totalEmployeesList['users'][index]["name"][0]),
            ),
            title: Row(
              children: [
                Expanded(
                    child: Text(
                        widget.totalEmployeesList['users'][index]["email"])),
                Expanded(
                    child: Text(
                        widget.totalEmployeesList['users'][index]["name"])),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmployeeDetail(widget.totalEmployeesList['users'][index]),
                ),
              );
            },
          )
        ]);
      },
    );
  }

  void logOut() {
    Navigator.pop(context);
  }
}
