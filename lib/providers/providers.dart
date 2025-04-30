import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yanga/models/course.model.dart';

final courseProvider = StateProvider<Course>((ref) {
  return Course.initial();
});

final emailProvider = StateProvider<String>((ref) => '');

final showPasswordProvider = StateProvider((ref) => false);
