import 'package:flutter/material.dart';
import 'package:w_health/user.dart';
import 'package:w_health/exercise.dart';
import 'package:w_health/excercise_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';



class ActiveBreak extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(
          title: Text('Default Exercises'),
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: exerciseList.length,
            itemBuilder: (context, index) {
              Exercise exercise = exerciseList[index];
              return Card(
                child: ListTile(
                  title: Text(exercise.title),
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    imageUrl: exercise.imageUrl,
                  ),
                  trailing: Icon(Icons.arrow_forward_rounded),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExerciseDetailsScreen(exercise)));
                  },
                ),
              );
            }));
  }
}