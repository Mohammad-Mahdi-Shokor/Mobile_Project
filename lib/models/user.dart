// class User {
//   final int? id;
//   final String username;
//   final String firstName;
//   final String tag;
//   final int age;
//   final String gender;
//   final String profilePicture;

//   User({
//     this.id,
//     required this.username,
//     required this.firstName,
//     required this.tag,
//     required this.age,
//     required this.gender,
//     required this.profilePicture,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'username': username,
//       'firstName': firstName,
//       'tag': tag,
//       'age': age,
//       'gender': gender,
//       'profilePicture': profilePicture,
//     };
//   }

//   static User fromMap(Map<String, dynamic> map) {
//     return User(
//       id: map['id'] as int?,
//       username: map['username'] as String,
//       firstName: map['firstName'] as String,
//       tag: map['tag'] as String,
//       age: map['age'] as int,
//       gender: map['gender'] as String,
//       profilePicture: map['profilePicture'] as String,
//     );
//   }

//   User copyWith({
//     int? id,
//     String? username,
//     String? firstName,
//     String? tag,
//     int? age,
//     String? gender,
//     String? profilePicture,
//   }) {
//     return User(
//       id: id ?? this.id,
//       username: username ?? this.username,
//       firstName: firstName ?? this.firstName,
//       tag: tag ?? this.tag,
//       age: age ?? this.age,
//       gender: gender ?? this.gender,
//       profilePicture: profilePicture ?? this.profilePicture,
//     );
//   }
// }
