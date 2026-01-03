// class Lesson {
//   final int? id;
//   final int courseId;
//   final String title;
//   final bool isCompleted;

//   Lesson({
//     this.id,
//     required this.courseId,
//     required this.title,
//     required this.isCompleted,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'course_id': courseId,
//       'title': title,
//       'is_completed': isCompleted ? 1 : 0,
//     };
//   }

//   static Lesson fromMap(Map<String, dynamic> map) {
//     return Lesson(
//       id: map['id'] as int?,
//       courseId: map['course_id'] as int,
//       title: map['title'] as String,
//       isCompleted: (map['is_completed'] as int) == 1,
//     );
//   }

//   Lesson copyWith({int? id, int? courseId, String? title, bool? isCompleted}) {
//     return Lesson(
//       id: id ?? this.id,
//       courseId: courseId ?? this.courseId,
//       title: title ?? this.title,
//       isCompleted: isCompleted ?? this.isCompleted,
//     );
//   }
// }
