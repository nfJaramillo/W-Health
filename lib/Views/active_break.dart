import 'package:flutter/material.dart';
import 'package:w_health/Views/exercise.dart';
import 'package:w_health/Views/exercise_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';



class ActiveBreak extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Default Exercises'),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: exerciseList.length,
            itemBuilder: (context, index) {
              Exercise exercise = exerciseList[index];
              return Card(
                child: ListTile(
                  title: Text(exercise.title),
                  leading: CachedNetworkImage(
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    imageUrl: exercise.imageUrl,
                    width: 50,
                    height: 50
                  ),
                  trailing: const Icon(Icons.arrow_forward_rounded),
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