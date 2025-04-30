import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:yanga/constants.dart';
import 'package:yanga/models/course.model.dart';
import 'package:yanga/widgets/app_bar.widget.dart';
import 'package:yanga/widgets/featured_course.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<String> _routes = ['/home', '/courses', '/mentorship', '/profile'];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    QR.to(_routes[index]); // Navigate using Qlevar Router
  }

  void _logout() {
    QR.to('/'); // Redirect to login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title:
              'Yanga Learning'), //AppBar(title: const Text('Yanga Learning')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => QR.to('/home'),
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Courses'),
              onTap: () => QR.to('/courses'),
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Mentorship'),
              onTap: () => QR.to('/mentorship'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () => QR.to('/profile'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [FeaturedCourses(courses: courses)],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Mentorship'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
