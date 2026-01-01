import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/widgets/theme.dart';
import 'package:mobile_project/models/data.dart';

class TestScreen extends StatefulWidget {
  final String section;
  final List<Question> questions;

  const TestScreen({super.key, required this.section, required this.questions});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int currentIndex = 0;
  int correctAnswers = 0;
  bool answered = false;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final question = widget.questions[currentIndex];

    // Shuffle answers visually but keep first answer as correct
    List<Answer> answers = List.from(question.answers);
    answers.shuffle(Random(currentIndex));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.section),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Q${currentIndex + 1}: ${question.question}',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 40),
              ...List.generate(answers.length, (i) {
                bool isSelected = i == selectedIndex;
                bool isCorrect = answers[i].answer == question.answers[0].answer;

                Color bgColor;
                if (!answered) {
                  bgColor = theme.colorScheme.secondary;
                } else {
                  bgColor = isSelected
                      ? (isCorrect ? Colors.green : Colors.red)
                      : theme.colorScheme.secondary;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Material(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: answered ? null : () => _selectAnswer(i, isCorrect),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        alignment: Alignment.center,
                        child: Text(
                          answers[i].answer,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: theme.textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _selectAnswer(int index, bool isCorrect) {
    setState(() {
      answered = true;
      selectedIndex = index;
      if (isCorrect) correctAnswers++;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (currentIndex + 1 < widget.questions.length) {
        setState(() {
          currentIndex++;
          answered = false;
          selectedIndex = -1;
        });
      } else {
        int score = ((correctAnswers / widget.questions.length) * 100).round();
        Navigator.pop(context, score);
      }
    });
  }
}
