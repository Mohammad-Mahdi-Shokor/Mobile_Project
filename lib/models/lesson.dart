import 'Question.dart';

class Lesson {
  final String title;
  final List<Question> questions;
  final bool done; // Changed `Done` to `done` for naming convention consistency
  int get numberOfQuestions => questions.length; // Dynamically calculated
  int numberOfAnswered = 0;

  Lesson({required this.title, required this.questions, required this.done});
}
