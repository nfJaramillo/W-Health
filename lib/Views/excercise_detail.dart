import 'package:flutter/material.dart';
import 'package:w_health/Views/exercise.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  final Exercise exercise;

  ExerciseDetailsScreen(this.exercise);

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;

     return Scaffold(
       
      backgroundColor: Colors.white,
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
                     color: Color(0xFF7086B2),
                     borderRadius: BorderRadius.only(
                       bottomLeft: Radius.circular(50),
                       topLeft: Radius.circular(50)
                     ),
                     boxShadow: [
                       BoxShadow(
                         offset: Offset(0, 5),
                         blurRadius: 50,
                         color: Color.fromARGB(255, 229, 229, 236).withOpacity(0.2)
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
                     color: Color(0xFF7086B2),
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
                     color: Color(0xFFF17105),
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
              )
          
       ],
     )
    );
    
    
    
    
  }
}