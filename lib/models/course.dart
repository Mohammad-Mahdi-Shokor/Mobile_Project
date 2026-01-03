// class Course {
//   final int? id;
//   final String title;
//   final String description;
//   final int numberOfFinished;
//   final String about;
//   final String imageUrl;
//   final bool isRegistered;
//   final List<String>? sections; // Add this
//   final List<dynamic>? lessons; // Add this for compatibility

//   Course({
//     this.id,
//     required this.title,
//     required this.description,
//     required this.numberOfFinished,
//     required this.about,
//     required this.imageUrl,
//     this.isRegistered = false,
//     this.sections,
//     this.lessons,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'about': about,
//       'imageUrl': imageUrl,
//       'number_of_finished': numberOfFinished,
//     };
//   }

//   static Course fromMap(Map<String, dynamic> map) {
//     return Course(
//       id: map['id'] as int?,
//       title: map['title'] as String,
//       description: map['description'] as String,
//       about: map['about'] as String,
//       imageUrl: map['imageUrl'] as String,
//       numberOfFinished: map['number_of_finished'] as int,
//       isRegistered: false,
//     );
//   }

//   Course copyWith({
//     int? id,
//     String? title,
//     String? description,
//     int? numberOfFinished,
//     String? about,
//     String? imageUrl,
//     bool? isRegistered,
//     List<String>? sections,
//     List<dynamic>? lessons,
//   }) {
//     return Course(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       description: description ?? this.description,
//       numberOfFinished: numberOfFinished ?? this.numberOfFinished,
//       about: about ?? this.about,
//       imageUrl: imageUrl ?? this.imageUrl,
//       isRegistered: isRegistered ?? this.isRegistered,
//       sections: sections ?? this.sections,
//       lessons: lessons ?? this.lessons,
//     );
//   }
// }
