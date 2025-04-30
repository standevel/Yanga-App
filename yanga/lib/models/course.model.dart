class Course {
  final String title;
  final String description;
  final String imageUrl;
  final double ratings; // Added rating
  final double price; // Added price
  final dynamic instructor; // Added instructor
  final String category;
  final List<String> syllabus;
  final int numberOfRatings;

  final String id;

  Course(
      {required this.title,
      required this.description,
      required this.imageUrl,
      required this.numberOfRatings,
      required this.syllabus,
      required this.id,
      this.ratings = 4.0, // Default rating
      this.price = 99.99, // Default price
      this.instructor = "John Doe", // Default instructor
      this.category = "Web"});

  factory Course.initial() {
    return Course(
      title: 'Default Title',
      description: 'Default Description',
      imageUrl: 'https://via.placeholder.com/150',
      syllabus: [],
      id: 'default',
      ratings: 4.0,
      price: 99.99,
      instructor: {"name": "John Doe", "bio": "Default Bio", "imageUrl": ""},
      category: 'Web',
      numberOfRatings: 0,
    );
  }
}
