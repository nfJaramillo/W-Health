import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Exercise {

  String title;
  String description;
  String imageUrl;
  bool isLoading = true;

  Exercise(
      {required this.title,
      required this.description,
      required this.imageUrl});


}       

final urlImages = [
  'https://upload.wikimedia.org/wikipedia/commons/a/ad/Woman_on_the_yoga_mat_stretching_her_hamstrings_-_50398044188.jpg',
  'https://upload.wikimedia.org/wikipedia/commons/d/d4/Jogging_couple_-_legs.jpg',
  'https://upload.wikimedia.org/wikipedia/commons/c/c7/Woman_yoga_pose.jpg'
];

List<Exercise> exerciseList = [
  Exercise(
      title: 'Stretching',
      description:
          'Is a form of physical exercise in which a specific muscle or tendon (or muscle group) is deliberately flexed or stretched in order to improve the muscles felt elasticity and achieve comfortable muscle tone.[1] The result is a feeling of increased muscle control, flexibility, and range of motion.',
      imageUrl:
          urlImages[0]),
  Exercise(
      title: 'Jogging',
      description:
          'is a form of trotting or running at a slow or leisurely pace.',
      imageUrl: 
          urlImages[1]),
  Exercise(
      title: 'Yoga',
      description:
          'The ultimate goals of yoga are stilling the mind and gaining insight, resting in detached awareness, and liberation',
      imageUrl:
          urlImages[2])
];