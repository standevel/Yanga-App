import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yanga/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserLoggedIn();
  }

  Future<void> _checkUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    bool goToLogin = prefs.getBool('goToLogin') ?? false;
    Future.delayed(const Duration(seconds: 2), () {
      if (isLoggedIn) {
        QR.to('/home');
      }
      if (goToLogin) {
        QR.to('/login');
      } else {
        QR.to('/start');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset('assets/images/yanga2.png', width: 200),
                const SizedBox(height: 20),
                const Text("Yanga Learning Platform",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("Transforming education for a brighter future."),
                const SizedBox(height: 20),
                // Expanded(
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 120, vertical: 15)),
              onPressed: () => QR.toName(AppRoutes.signupRoute),
              child: const Text("Get Started"),
            ),
          ],
        ),
      ),
    );
  }
}
