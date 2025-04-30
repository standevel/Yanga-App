import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:yanga/constants.dart';
import 'package:yanga/pages/enroll.widget.dart';
import 'package:yanga/providers/providers.dart';
import 'package:yanga/widgets/ratings.widget.dart';
import 'package:yanga/widgets/submit_button.widget.dart';

class CourseDetailsPage extends ConsumerStatefulWidget {
  const CourseDetailsPage({super.key});

  @override
  ConsumerState<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends ConsumerState<CourseDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var course = ref.read(courseProvider);
      // Replace print statements with logging
      debugPrint('loaded course :{$course}');
      if (course.title.contains('Default Title')) {
        debugPrint('Is Default title');
        final courseId = QR.params['id'] as String?;
        debugPrint('courseId: $courseId');
        if (courseId != null) {
          final selectedCourse =
              courses.firstWhere((element) => element.id == courseId);
          ref.read(courseProvider.notifier).state = selectedCourse;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final course = ref.watch(courseProvider);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
        body: SingleChildScrollView(
            child: ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          children: [
            Container(
              height: isMobile ? 200 : 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(course.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                course.title,
                softWrap: true,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (!isMobile)
              Positioned(
                bottom: 20,
                right: 20,
                child: SubmitButton(
                  onTap: () {
                    print('Enron button clicked');
                  },
                  title: 'Enroll Now',
                ),
              )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if (isMobile) EnrollCard(price: course.price),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Syllabus',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: course.syllabus.map((item) => Text(item)).toList(),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: isMobile ? double.infinity : 800,
                child: const Text('Description',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              Text(course.description, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              const Text('Author',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: isMobile ? 20 : 30,
                    backgroundImage: NetworkImage((course.instructor
                        as Map<String, String>)['imageUrl']!),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (course.instructor as Map<String, String>)['name']!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          (course.instructor as Map<String, String>)['bio']!,
                          style: const TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              EnrollCard(price: course.price),
              const SizedBox(height: 16),
              const Text('Featured Ratings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Column(
                children: [
                  ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/user1.jpg'),
                      ),
                      title: const Text('Jane Smith'),
                      subtitle: const Text('Great course! Highly recommend.'),
                      trailing: RatingWidget(
                          rating: course.ratings,
                          numberOfRatings: course.numberOfRatings)),
                  ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/user2.jpg'),
                      ),
                      title: const Text('Michael Brown'),
                      subtitle:
                          const Text('Very informative and well-structured.'),
                      trailing: RatingWidget(
                          rating: course.ratings,
                          numberOfRatings: course.numberOfRatings))
                ],
              ),
              EnrollCard(price: course.price),
              const SizedBox(height: 16),
            ],
          ),
        ),
        //  More on feateured rating
      ]),
    )));
  }
}
