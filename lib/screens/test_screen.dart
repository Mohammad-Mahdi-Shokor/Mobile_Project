import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/models/data.dart';

class TestScreen extends StatefulWidget {
  final String section;
  final List<Question> questions;
  final int courseId; // Add courseId parameter
  final int totalLessons; // Add total lessons for progress calculation
  final VoidCallback? onTestCompleted; // Callback when test is completed

  const TestScreen({
    super.key,
    required this.section,
    required this.questions,
    required this.courseId,
    required this.totalLessons,
    this.onTestCompleted,
  });

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int currentIndex = 0;
  int correctAnswers = 0;
  bool answered = false;
  int selectedIndex = -1;
  late List<Answer> currentAnswers;

  @override
  void initState() {
    super.initState();
    _shuffleCurrentAnswers();
  }

  void _shuffleCurrentAnswers() {
    final question = widget.questions[currentIndex];
    List<Answer> answers = List.from(question.answers);
    Answer correct = answers.removeAt(0);
    answers.shuffle();
    answers.insert(Random().nextInt(answers.length + 1), correct);
    currentAnswers = answers;
  }

  void _showTestResult(int score) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: const Text('Test Completed'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'You scored: $score%',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Correct: $correctAnswers/${widget.questions.length}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                _buildScoreEmoji(score),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(
                    context,
                    score,
                  ); // Return to previous screen with score
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  Widget _buildScoreEmoji(int score) {
    if (score >= 80) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emoji_events, color: Colors.amber, size: 40),
          const SizedBox(width: 10),
          Text(
            'Excellent!',
            style: TextStyle(
              fontSize: 18,
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else if (score >= 60) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.thumb_up, color: Colors.green, size: 40),
          const SizedBox(width: 10),
          Text(
            'Good Job!',
            style: TextStyle(
              fontSize: 18,
              color: Colors.blue[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.refresh, color: Colors.orange, size: 40),
          const SizedBox(width: 10),
          Text(
            'Keep Practicing',
            style: TextStyle(
              fontSize: 18,
              color: Colors.orange[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final question = widget.questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.section),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${currentIndex + 1}/${widget.questions.length}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Score: $correctAnswers/${widget.questions.length}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: (currentIndex + 1) / widget.questions.length,
              backgroundColor: Colors.grey[300],
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 20),

            // Question
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              'Q${currentIndex + 1}',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              question.question,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: theme.textTheme.bodyLarge?.color,
                              ),
                            ),
                            // if (question.hint != null && question.hint!.isNotEmpty)
                            //   Padding(
                            //     padding: const EdgeInsets.only(top: 10),
                            //     child: Text(
                            //       'Hint: ${question.hint!}',
                            //       style: GoogleFonts.poppins(
                            //         fontSize: 14,
                            //         fontStyle: FontStyle.italic,
                            //         color: Colors.orange[700],
                            //       ),
                            //     ),
                            //   ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Answers
                    ...List.generate(currentAnswers.length, (i) {
                      bool isSelected = i == selectedIndex;
                      bool isCorrect =
                          currentAnswers[i].answer ==
                          question.answers[0].answer;

                      Color bgColor;
                      IconData? icon;
                      Color? iconColor;

                      if (!answered) {
                        bgColor = theme.colorScheme.secondary.withOpacity(0.1);
                      } else {
                        if (isSelected) {
                          bgColor =
                              isCorrect
                                  ? Colors.green.withOpacity(0.2)
                                  : Colors.red.withOpacity(0.2);
                          icon = isCorrect ? Icons.check_circle : Icons.cancel;
                          iconColor = isCorrect ? Colors.green : Colors.red;
                        } else if (isCorrect) {
                          bgColor = Colors.green.withOpacity(0.2);
                          icon = Icons.check_circle;
                          iconColor = Colors.green;
                        } else {
                          bgColor = theme.colorScheme.secondary.withOpacity(
                            0.1,
                          );
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Material(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap:
                                answered
                                    ? null
                                    : () => _selectAnswer(i, isCorrect),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 20,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      currentAnswers[i].answer,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: theme.textTheme.bodyLarge?.color,
                                        fontWeight:
                                            isSelected
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  if (icon != null)
                                    Icon(icon, color: iconColor, size: 24),
                                ],
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

            // Next/Finish Button
            if (answered)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentIndex + 1 < widget.questions.length) {
                        setState(() {
                          currentIndex++;
                          answered = false;
                          selectedIndex = -1;
                          _shuffleCurrentAnswers();
                        });
                      } else {
                        int score =
                            ((correctAnswers / widget.questions.length) * 100)
                                .round();
                        _showTestResult(score);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      currentIndex + 1 < widget.questions.length
                          ? 'Next Question'
                          : 'See Results',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
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
  }
}
