import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yanga/models/course.model.dart';
import 'package:yanga/routes.dart';

const baseUrl =
    'https://yanga-api-1.onrender.com/api/v1/'; // Replace with actual API URL
// const api='https://'

getWidth(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}

isMobile(BuildContext context) => getWidth(context) < 600;

void showToastMessage(String message,
    {Color color = Colors.white, backgroundColor = Colors.green}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 2,
    backgroundColor: color,
    textColor: backgroundColor,
    fontSize: 16.0,
  );
}

Future<void> checkUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  bool goToLogin = prefs.getBool('goToLogin') ?? false;
  prefs.setBool('goToLogin', true);
  Future.delayed(const Duration(seconds: 2), () {
    if (isLoggedIn) {
      QR.toName(AppRoutes.homeRoute);
    }
    if (goToLogin) {
      QR.toName(AppRoutes.loginRoute);
    } else {
      QR.to(AppRoutes.startRoute);
    }
  });
}

final List<Course> courses = [
  Course(
      id: 'fjdsfjds',
      title: 'Python 101: Beginner to Intermediate',
      syllabus: ['Introduction to Python', 'Data Structures', 'Functions'],
      description:
          'A comprehensive introduction to Python programming, covering fundamental concepts and data structures.',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsx2uP-_J-2tiPSoTc1JgMbSh7eFxQ8oAFZQ&s',
      ratings: 4.5,
      price: 49.99,
      instructor: {
        "name": 'Alice Cooper',
        "bio":
            'Alice Cooper is a seasoned software engineer with over 10 years of experience in Python development. She has worked on various projects ranging from web development to data analysis and is passionate about teaching programming to beginners.',
        "imageUrl": 'https://via.placeholder.com/150'
      },
      numberOfRatings: 300),
  Course(
      id: 'fidldskd',
      syllabus: [
        'Introduction to Digital Marketing',
        'SEO',
        'Social Media Marketing'
      ],
      title: 'Digital Marketing Fundamentals',
      description:
          'Learn the core principles of digital marketing, including SEO, social media marketing, and content strategy.',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsx2uP-_J-2tiPSoTc1JgMbSh7eFxQ8oAFZQ&s',
      ratings: 4.2,
      price: 79.99,
      instructor: {
        "name": 'Bob Dylan',
        "bio":
            'Bob Dylan is a digital marketing expert with over 8 years of experience in SEO, social media marketing, and content strategy. He has helped numerous businesses grow their online presence and achieve their marketing goals.',
        "imageUrl": 'https://via.placeholder.com/150'
      },
      numberOfRatings: 200),
  Course(
      id: 'fjdsfjds',
      title: 'Web Development with React',
      syllabus: [
        'Introduction to React',
        'Building Components',
        'State Management'
      ],
      description:
          'Build interactive web applications using React, a popular JavaScript library.',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsx2uP-_J-2tiPSoTc1JgMbSh7eFxQ8oAFZQ&s',
      ratings: 4.7,
      price: 99.99,
      instructor: {
        "name": 'Charlie Chaplin',
        "bio":
            'Charlie Chaplin is a professional web developer with expertise in React and modern web technologies. He has built scalable web applications for startups and enterprises and enjoys mentoring aspiring developers.',
        "imageUrl": 'https://via.placeholder.com/150'
      },
      numberOfRatings: 600),
  Course(
      id: 'fidldskd',
      title: 'Mobile App Development with Flutter',
      syllabus: [
        'Introduction to Flutter',
        'Building UIs with Flutter',
        'State Management'
      ],
      description:
          'Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.Create native mobile apps for iOS and Android using the Flutter framework.v',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi-FGd8dbgOqIz-n65GXouw-fdgl7M5Kfk3g&s',
      ratings: 4.6,
      price: 129.99,
      instructor: {
        "name": 'Diana Prince',
        "bio":
            'Diana Prince is a mobile app developer with extensive experience in building cross-platform applications using Flutter. She is passionate about creating seamless user experiences and sharing her knowledge with others.My name is Stéphane Maarek, I am passionate about Cloud Computing, and I will be your instructor in this course. I teach about AWS certifications, focusing on helping my students improve their professional proficiencies in AWS.I have already taught 1,500,000+ students and gotten 500,000+ reviews throughout my career in designing and delivering these certifications and courses!With AWS becoming the centerpiece of today\'s modern IT architectures, I\'ve decided it\'s time for students to learn how to be an AWS Cloud Practitioner. So, let’s kick start the course! You are in good hands!',
        "imageUrl": 'https://via.placeholder.com/150'
      },
      numberOfRatings: 50),
  Course(
      id: 'fjdsfjds',
      syllabus: [
        'History of Data science',
        'Tools used in Data Science',
        'Data Science Process'
      ],
      title: 'Data Science and Machine Learning',
      description:
          'Dive into the world of data science and machine learning, learning how to analyze data and build predictive models.',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsx2uP-_J-2tiPSoTc1JgMbSh7eFxQ8oAFZQ&s',
      ratings: 4.4,
      price: 149.99,
      instructor: {
        "name": 'Eve Adams',
        "bio":
            'Eve Adams is a data scientist with a PhD in Computer Science and over 7 years of experience in data analysis and machine learning. She has worked on cutting-edge projects in AI and is dedicated to helping others understand the power of data.',
        "imageUrl": 'https://via.placeholder.com/150'
      },
      numberOfRatings: 100),
];
