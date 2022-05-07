import 'dart:async';

import 'package:flutter/material.dart';
import 'package:w_health/Views/exercise.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:w_health/Elements/button_widget.dart';
import 'package:w_health/Views/timer.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  final Exercise exercise;
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  ExerciseDetailsScreen(this.exercise);

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;

     return Scaffold(
       
      backgroundColor: Theme.of(context).colorScheme.background,
      body: 
      ListView(
      children: <Widget>[
         Container(
           height: size.height * 0.4,
           child: Stack(
             children: <Widget>[
               Container(
                 height: size.height * 0.4 - 50,
                 child: 
                 CachedNetworkImage(
                  imageUrl: exercise.imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: 
                        BorderRadius.only(bottomLeft: Radius.circular(50)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: imageProvider
                      ),
                  ),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) => 
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
                  ), 
                ),
               Positioned(
                 bottom: 0,
                 right: 0,
                 child: Container(
                   width: size.width * 0.9,
                   height: 100,
                   decoration: BoxDecoration(
                     color: Theme.of(context).colorScheme.primary,
                     borderRadius: BorderRadius.only(
                       bottomLeft: Radius.circular(50),
                       topLeft: Radius.circular(50)
                     ),
                     boxShadow: [
                       BoxShadow(
                         offset: Offset(0, 5),
                         blurRadius: 50,
                         color: Theme.of(context).colorScheme.onPrimary
                          )
                      ]
                   ),
                   alignment: Alignment.center,
                   child:
                   Text(
                    "How to do it",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                    ),
                  ),
                 
               ),
             ],
           ),
         ),
         SizedBox(height: 10),
         Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                     color: Theme.of(context).colorScheme.primary,
                     borderRadius: BorderRadius.only(
                       bottomLeft: Radius.circular(50),
                       topLeft: Radius.circular(50),
                       topRight: Radius.circular(50),
                       bottomRight: Radius.circular(50)
                     ),
                ),
                padding: const EdgeInsets.all(25.0),
                child:
                Text(
                  exercise.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white),
                ),
              ),
          Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                     color: Theme.of(context).colorScheme.secondaryVariant,
                     borderRadius: BorderRadius.only(
                       bottomLeft: Radius.circular(50),
                       topLeft: Radius.circular(50),
                       topRight: Radius.circular(50),
                       bottomRight: Radius.circular(50)
                     ),
                ),
                padding: const EdgeInsets.all(25.0),
                child:
                Text(
                  "If you want further guidance visit WikiHow.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                    ),
                ),
              ),
              SizedBox(height: 10),
              ButtonWidget(text: 'Lets Do It!', onClicked: (){
               Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TimerView()));

            })
          
       ],
     )
    );    
  }

}