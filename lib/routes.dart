import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:yanga/pages/course_details.page.dart';
import 'package:yanga/pages/courses.page.dart';
import 'package:yanga/pages/home.page.dart';
import 'package:yanga/pages/login.page.dart';
import 'package:yanga/pages/mentorship.page.dart';
import 'package:yanga/pages/profile.page.dart';
import 'package:yanga/pages/signup.page.dart';
import 'package:yanga/pages/splashscreen.page.dart';
import 'package:yanga/pages/verify_email.page.dart';
import 'package:yanga/services/account_service.dart';

class AppRoutes {
  static const String splashScreenRoute = '/';
  static String homeRoute = 'home';
  static String loginRoute = 'login';
  static String signupRoute = 'signup';
  static String coursesRoute = 'courses';
  static String courseDetailRoute = 'courseDetail';
  static String mentorshipRoute = 'mentorship';
  static String startRoute = 'start';
  static String verifyEmailRoute = 'verifyEmail';

  static final routes = [
    QRoute(
      name: splashScreenRoute,
      path: '/',
      builder: () => const SplashScreen(),
    ),
    QRoute(path: '/login', name: loginRoute, builder: () => const LoginPage()),
    QRoute(
        path: '/signup', builder: () => const SignupPage(), name: signupRoute),
    QRoute(
        path: '/courses',
        name: coursesRoute,
        builder: () => const CoursesPage()),
    QRoute(
      path: '/course-details/:id',
      builder: () => const CourseDetailsPage(),
      name: courseDetailRoute,
    ),
    QRoute(
        path: '/verify-email',
        name: verifyEmailRoute,
        builder: () => const EmailVerificationPage()),
    QRoute(path: '/mentorship', builder: () => const MentorshipPage()),
    QRoute(path: '/profile', builder: () => const ProfilePage()),
    QRoute(path: '/start', builder: () => const StartPage(), name: startRoute),
    QRoute(
      name: homeRoute,
      path: '/home',
      builder: () => const HomePage(),
      middleware: [AuthMiddleware()], // Protect Home Page
    ),
  ];
}

class AuthMiddleware extends QMiddleware {
  @override
  Future onEnter() async {
    // Check if user is authenticated
    final token = await AccountService().getToken();
    print('found token: $token');
    if (token == null) {
      QR.to('/'); // Redirect to login if not logged in
    }
  }
}
//   