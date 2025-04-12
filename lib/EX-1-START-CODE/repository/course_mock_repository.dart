import '../models/course.dart';
import 'course_repository.dart';

class CoursesMockRepository implements CoursesRepository {
  final _courses = [
    Course(name: "Flutter"),
    Course(name: "Data Science"),
    Course(name: "Game Development"),
  ];

  @override
  Future<List<Course>> fetchCourses() async {
    await Future.delayed(const Duration(seconds: 1));
    return _courses;
  }

  @override
  Future<void> saveScore(Course course, CourseScore score) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _courses.indexWhere((c) => c.name == course.name);
    if (index != -1) _courses[index].addScore(score);
  }
}