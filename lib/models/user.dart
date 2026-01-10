import '../services/registered_course.dart';

class User {
  final String username;
  final String FirstName;
  final String tag;
  final int age;
  final String Gender;
  final String profilePicture;
  final List<double> achievementsScores;
  final List<RegisteredCourse> registeredCourses;
  final List<int> registedCoursesIndexes;

  User({
    required this.username,
    required this.tag,
    required this.age,
    required this.Gender,
    this.profilePicture =
        "https://cdn.wallpapersafari.com/95/19/uFaSYI.jpg", // Default value added
    required this.achievementsScores,
    required this.registeredCourses,
    required this.FirstName,
    required this.registedCoursesIndexes,
  });

  // Convert to Map for SQL insert
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'firstName': FirstName,
      'tag': tag,
      'age': age,
      'gender': Gender,
      'profilePicture': profilePicture,
    };
  }

  // Convert from SQL to Model
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] ?? '',
      FirstName: map['firstName'] ?? '',
      tag: map['tag'] ?? '',
      age: map['age'] ?? 0,
      Gender: map['gender'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      achievementsScores: [],
      registeredCourses: [],
      registedCoursesIndexes: [],
    );
  }

  // Copy with method for updates
  User copyWith({
    String? username,
    String? FirstName,
    String? tag,
    int? age,
    String? Gender,
    String? profilePicture,
    List<double>? achievementsScores,
    List<RegisteredCourse>? registeredCourses,
    List<int>? registedCoursesIndexes,
  }) {
    return User(
      username: username ?? this.username,
      FirstName: FirstName ?? this.FirstName,
      tag: tag ?? this.tag,
      age: age ?? this.age,
      Gender: Gender ?? this.Gender,
      profilePicture: profilePicture ?? this.profilePicture,
      achievementsScores: achievementsScores ?? this.achievementsScores,
      registeredCourses: registeredCourses ?? this.registeredCourses,
      registedCoursesIndexes:
          registedCoursesIndexes ?? this.registedCoursesIndexes,
    );
  }
}

final User sampleUser = User(
  username: "Mohammad Hammadi",
  FirstName: "Mohammad",
  tag: "Software Engineer",
  age: 21,
  Gender: "Male",
  profilePicture: "https://cdn.wallpapersafari.com/95/19/uFaSYI.jpg",
  achievementsScores: [0, 0.1, 0.3, 0.5, 0.7, 1, 1, 1, 1, 1, 1, 1, 1],
  registeredCourses: [],
  registedCoursesIndexes: [0, 1],
);
