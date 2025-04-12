import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';

import '../provider/course_provider.dart';
import 'course_screen.dart';

const Color mainColor = Colors.blue;

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) => Consumer<CoursesProvider>(
    builder:
        (ctx, provider, child) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: mainColor,
            title: const Text(
              'SCORE APP',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: ListView.builder(
            itemCount: provider.allCourses.length,
            itemBuilder:
                (ctx, index) => Dismissible(
                  key: Key(provider.allCourses[index].name),
                  child: CourseTile(
                    course: provider.allCourses[index],
                    onEdit:
                        (course) => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (ctx) => CourseScreen(courseId: course.name),
                          ),
                        ),
                  ),
                ),
          ),
        ),
  );
}

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.course, required this.onEdit});

  final Course course;
  final Function(Course) onEdit;

  int get numberOfScores => course.scores.length;

  String get numberText {
    return course.hasScore ? "$numberOfScores scores" : 'No score';
  }

  String get averageText {
    String average = course.average.toStringAsFixed(1);
    return course.hasScore ? "Average : $average" : '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            onTap: () => onEdit(course),
            title: Text(course.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(numberText), Text(averageText)],
            ),
          ),
        ),
      ),
    );
  }
}
