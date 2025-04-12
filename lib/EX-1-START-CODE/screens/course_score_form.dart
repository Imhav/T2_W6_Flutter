// lib/screens/course_score_form.dart
import 'package:flutter/material.dart';
import '../models/course.dart';

const Color mainColor = Colors.blue;

class CourseScoreForm extends StatefulWidget {
  const CourseScoreForm({super.key});

  @override
  State<CourseScoreForm> createState() {
    return _CourseScoreFormState();
  }
}

class _CourseScoreFormState extends State<CourseScoreForm> {
  final _formKey = GlobalKey<FormState>();
  String _enteredName = '';
  double _enteredScore = 50;

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(
        CourseScore(studentName: _enteredName, studentScore: _enteredScore),
      );
    }
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty || value.trim().length > 50) {
      return 'Must be between 1 and 50 characters.';
    }
    return null;
  }

  String? validateScore(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Score cannot be empty.';
    }
    final score = double.tryParse(value);
    if (score == null || score < 0 || score > 100) {
      return 'Must be a score between 0 and 100.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text("Add Score", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                initialValue: _enteredName,
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Name')),
                validator: validateName,
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: _enteredScore.toString(),
                decoration: const InputDecoration(label: Text('Score')),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: validateScore,
                onSaved: (value) {
                  _enteredScore = double.parse(value!);
                },
              ),
              const Expanded(child: SizedBox(height: 12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: const Text("Add Score"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
