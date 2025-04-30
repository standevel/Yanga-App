import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:yanga/models/course.model.dart';
import 'package:yanga/providers/providers.dart';
import 'package:yanga/routes.dart';
import 'package:yanga/widgets/price.widget.dart';
import 'package:yanga/widgets/ratings.widget.dart';

class CourseCard extends ConsumerWidget {
  final Course course;

  const CourseCard({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isHovered = false;

    return GestureDetector(
      onTap: () {
        debugPrint('CourseCard: ${course.title} ${course.imageUrl}');
        // Navigate to the details page
        ref.read(courseProvider.notifier).state = course;
        QR.toName(AppRoutes.courseDetailRoute, params: {'id': course.id});
      },
      child: StatefulBuilder(
        builder: (context, setState) {
          return MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 1),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          child: Image.network(
                            course.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error, size: 50);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              course.instructor['name'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            RatingWidget(
                              rating: course.ratings,
                              numberOfRatings: course.numberOfRatings,
                            ),
                            const SizedBox(height: 8),
                            PriceWidget(price: course.price),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (isHovered)
                  Positioned(
                    top: -10,
                    left: 0,
                    right: 0,
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          course.description,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
