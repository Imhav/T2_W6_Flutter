import 'package:flutter/material.dart';
import '../models/course.dart';
import '../repository/course_repository.dart';


class CoursesProvider extends ChangeNotifier {
  final CoursesRepository _repository;
  List<Course> _allCourses = [];

  CoursesProvider(this._repository);

  List<Course> get allCourses => _allCourses;

  Future<void> init() async {
    _allCourses = await _repository.fetchCourses();
    notifyListeners();
  }

  Course getCourse(String courseId) => _allCourses.firstWhere((course) => course.name == courseId);

  Future<void> saveScore(String courseId, CourseScore score) async {
    await _repository.saveScore(getCourse(courseId), score);
    notifyListeners();
  }
}