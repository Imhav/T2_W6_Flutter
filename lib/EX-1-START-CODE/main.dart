import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/course_provider.dart';
import 'repository/course_mock_repository.dart';
import 'screens/course_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CoursesProvider(CoursesMockRepository()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CourseListScreen(),
      ),
    ),
  );
}