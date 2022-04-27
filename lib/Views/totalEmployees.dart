
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';


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
        body: LoaderOverlay(
          child: totalEmployeesStructure()
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

  SingleChildScrollView totalEmployeesStructure() {
    return SingleChildScrollView(
    physics: const ScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          "Total employees",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40),
        ),
        Divider(
          height: 20,
          thickness: 2,
          indent: 20,
          endIndent: 20,
          color: Theme.of(context).colorScheme.primary,
        ),

        const SizedBox(
          height: 20,
        ),
    
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount:  widget.totalEmployeesList['users'].length,
          itemBuilder: (context,index){
            return  ListTile(
              title: Text(widget.totalEmployeesList['users'][index]["email"]),
            );
          },
        )
      ]
    ));
  }

  void logOut() {
    Navigator.pop(context);
  }
}
