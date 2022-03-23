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
    ),

     bottomNavigationBar: Container(
          height: 60,
          color: Colors.black12,
          child: InkWell(
            onTap: () => print('tap on close'),
            child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.logout,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text('Logout'),
                ],
              ),),),)


    );
  }

  Column supervisorStructure() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          "General Data",
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

        const SizedBox(height: 20,),

        // Total employees

        const Text(
          "Total employees",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(height: 15,),
        Row(
          children: <Widget>[
            const SizedBox(width: 50),
            Expanded(
              child: Icon(
                Icons.account_circle,
                color: Theme.of(context).colorScheme.primary,
                size: 40.0,
                semanticLabel: 'Icon for total employees',
              ),
            ),

            const Expanded(
              child:
                  Text('4', textAlign: TextAlign.center,style: TextStyle(fontSize: 30),),
            ),

            const SizedBox(width: 50),
            
          ],
        ),

        // Active employees

        const SizedBox(height: 20,),

        const Text(
          "Active employees",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(height: 15,),
        Row(
          children: <Widget>[
            const SizedBox(width: 50),
            Expanded(
              child: Icon(
                Icons.groups,
                color: Theme.of(context).colorScheme.primary,
                size: 40.0,
                semanticLabel: 'Icon for active employees',
              ),
            ),

            const Expanded(
              child:
                  Text('3', textAlign: TextAlign.center, style: TextStyle(fontSize: 30),),
            ),

            const SizedBox(width: 50),
            
          ],
        ),

        // Offline employees

        const SizedBox(height: 20,),

        const Text(
          "Offline employees",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(height: 15,),
        Row(
          children: <Widget>[
            const SizedBox(width: 50),
            Expanded(
              child: Icon(
                Icons.hotel,
                color: Theme.of(context).colorScheme.primary,
                size: 40.0,
                semanticLabel: 'Icon for offline employees',
              ),
            ),

            const Expanded(
              child:
                  Text('1', textAlign: TextAlign.center,style: TextStyle(fontSize: 30),),
            ),

            const SizedBox(width: 50),
            
          ],
        ),

        // Sick employees

        const SizedBox(height: 20,),

        const Text(
          "Sick employees",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25),
        ),

        const SizedBox(height: 15,),
        Row(
          children: <Widget>[
            const SizedBox(width: 50),
            Expanded(
              child: Icon(
                Icons.sick,
                color: Theme.of(context).colorScheme.primary,
                size: 40.0,
                semanticLabel: 'Icon for sick employees',
              ),
            ),

            const Expanded(
              child:
                  Text('0', textAlign: TextAlign.center,style: TextStyle(fontSize: 30),),
            ),

            const SizedBox(width: 50),
            
          ],
        ),

        const SizedBox(height: 50,),

        ElevatedButton(
          child: const Text("Review health surveys"),
          onPressed: () =>
              {reviewHealthSurveys()},
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            primary: Theme.of(context).colorScheme.primary,
            minimumSize: const Size.fromHeight(50),
          ),
        ),

        

       

      ],
    );
  }

  void reviewHealthSurveys(){

  }
}
