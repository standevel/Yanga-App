import 'package:flutter/material.dart';
import 'package:yanga/constants.dart';
import 'package:yanga/models/course.model.dart';
import 'package:yanga/widgets/course_card.widget.dart';
import 'package:yanga/widgets/search_text_field.widget.dart';

class FeaturedCourses extends StatelessWidget {
  final List<Course> courses;

  const FeaturedCourses({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchTextField(),
            const SizedBox(height: 20),
            Padding(
              padding: isMobile(context)
                  ? const EdgeInsets.only(left: 0.0)
                  : const EdgeInsets.only(left: 70),
              child: const Text(
                'Featured Courses',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            if (isMobile(context))
              ...courses.map((course) => CourseCard(
                    course: course,
                  )),
            if (!isMobile(context))
              Center(
                child: Wrap(
                  spacing: 20.0,
                  children: [
                    ...courses.map((course) => SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          height: 400,
                          child: CourseCard(
                            course: course,
                          ),
                        ))
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
