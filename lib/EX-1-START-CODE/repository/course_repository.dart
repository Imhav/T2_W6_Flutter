import '../models/course.dart';

abstract class CoursesRepository {
  Future<List<Course>> fetchCourses();
  Future<void> saveScore(Course course, CourseScore score);
}