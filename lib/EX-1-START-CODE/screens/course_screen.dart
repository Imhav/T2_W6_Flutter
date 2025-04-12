import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../provider/course_provider.dart';
import 'course_score_form.dart';

const Color mainColor = Colors.blue;

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key, required this.courseId});

  final String courseId;

  void _addScore(BuildContext context, CoursesProvider provider) async {
    CourseScore? newScore = await Navigator.of(context).push<CourseScore>(
      MaterialPageRoute(builder: (ctx) => const CourseScoreForm()),
    );

    if (newScore != null) {
      await provider.saveScore(courseId, newScore);
    }
  }

  Color scoreColor(double score) {
    return score > 50 ? Colors.green : Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoursesProvider>(
      builder: (ctx, provider, child) {
        final course = provider.getCourse(courseId);
        final scores = course.scores;

        Widget content = const Center(child: Text('No Scores added yet.'));
        if (scores.isNotEmpty) {
          content = ListView.builder(
            itemCount: scores.length + 1,
            itemBuilder: (ctx, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Average: ${course.average.toStringAsFixed(1)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              }
              return ListTile(
                title: Text(scores[index - 1].studentName),
                trailing: Text(
                  scores[index - 1].studentScore.toString(),
                  style: TextStyle(
                    color: scoreColor(scores[index - 1].studentScore),
                    fontSize: 15,
                  ),
                ),
              );
            },
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: mainColor,
            title: Text(course.name, style: const TextStyle(color: Colors.white)),
            actions: [
              IconButton(
                onPressed: () => _addScore(context, provider),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: content,
        );
      },
    );
  }
}