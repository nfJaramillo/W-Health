
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Personalized extends StatefulWidget {
  @override
    _Personalized createState() => _Personalized();

}

class _Personalized extends State<Personalized> {
  var locationMessage = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Personalized Routine") ,
        ),
        body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, size: 45.0, color: Colors.blue),
            const SizedBox(height: 10.0),
            const Text("Get user Location", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20.0,),
            Text("Position: $locationMessage"),
            FlatButton(
              onPressed: (){getCurrentLocation();},
              color: Theme.of(context).colorScheme.primary, 
              child: const Text("Get Current Location", style: TextStyle(color: Colors.white,  ),))
            ],
          ),
        ), 
        bottomNavigationBar: Container(
          height: 60,
          color: Colors.black12,
          child: InkWell(
            onTap: () => goBack(),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.logout,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const Text('Back to Home'),
                ],
              ),
            ),
          ),
        )
    );
  }

  void goBack(){
    Navigator.pop(context);
  }

  void getCurrentLocation() async
  {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    var lat = position.latitude;
    var long = position.longitude;

    setState(() {
      locationMessage = "Latitude: $lat, Longitude: $long";
    });
  }
 
}