import 'package:flutter/material.dart';

class MentorshipPage extends StatelessWidget {
  const MentorshipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mentorships')),
      body: const Center(
          child: Text('Your enrolled mentorships will appear here!')),
    );
  }
}
