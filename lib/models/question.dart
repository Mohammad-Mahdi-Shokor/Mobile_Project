// class Question {
//   final int? id;
//   final int lessonId;
//   final String question;
//   final String answer1;
//   final String answer2;
//   final String answer3;
//   final int correctAnswerIndex;

//   Question({
//     this.id,
//     required this.lessonId,
//     required this.question,
//     required this.answer1,
//     required this.answer2,
//     required this.answer3,
//     this.correctAnswerIndex = 0, // Default first answer is correct
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'lesson_id': lessonId,
//       'question_text': question,
//       'answer1': answer1,
//       'answer2': answer2,
//       'answer3': answer3,
//       'correct_answer_index': correctAnswerIndex,
//     };
//   }

//   static Question fromMap(Map<String, dynamic> map) {
//     return Question(
//       id: map['id'] as int?,
//       lessonId: map['lesson_id'] as int,
//       question: map['question_text'] as String,
//       answer1: map['answer1'] as String,
//       answer2: map['answer2'] as String,
//       answer3: map['answer3'] as String,
//       correctAnswerIndex: map['correct_answer_index'] as int,
//     );
//   }
// }
