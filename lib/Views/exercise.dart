
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
          'Gradually and carefully move your body or the limb being stretched into the stretch position. Once you feel slight tension in the muscle, hold the position. Avoid bouncing or any other movements, which could overstretch the muscle and result in injury. Wait 15 seconds and then stretch further.',
      imageUrl:
          urlImages[0]),
  Exercise(
      title: 'Jogging',
      description:
          'Here are the steps to performing Jogging in Place: First start standing with feet hip distance apart.Then lift one foot then the other to jog in place working your legs and increasing your heart rate. Doing this for at least 150 minutes with moderate intensity will help you combat heart disease, diabetes and other chronic diseases.',
      imageUrl: 
          urlImages[1]),
  Exercise(
      title: 'Yoga',
      description:
          'The ultimate goals of yoga are stilling the mind and gaining insight, resting in detached awareness, and liberation. We recommend you to try the following yoga poses: Downward-Facing Dog, Mountain Pose, Crescent Lunge and Triangle. Google these poses, they will help, you release stress and thay are easy to do!',
      imageUrl:
          urlImages[2])
];

