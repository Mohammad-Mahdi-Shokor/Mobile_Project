import '../services/registered_course.dart';

class User {
  final String username;
  final String fullName;
  final String tag;
  final int age;
  final String gender;
  final String profileImage;
  final List<double> achievementsProgress;
  final List<CourseInfo> registeredCourses;
  final List<int> registedCoursesIndexes;

  User({
    required this.username,
    required this.tag,
    required this.age,
    required this.gender,
    this.profileImage =
        "https://cdn.wallpapersafari.com/95/19/uFaSYI.jpg", // Default image
    required this.achievementsProgress,
    required this.registeredCourses,
    required this.fullName,
    required this.registedCoursesIndexes,
  });

  // Convert to Map for SQL insert
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'firstName': fullName,
      'tag': tag,
      'age': age,
      'gender': gender,
      'profilePicture': profileImage,
    };
  }

  // Convert from SQL to Model
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] ?? '',
      fullName: map['firstName'] ?? '',
      tag: map['tag'] ?? '',
      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
      profileImage: map['profilePicture'] ?? '',
      achievementsProgress: [],
      registeredCourses: [],
      registedCoursesIndexes: [],
    );
  }

  User copyWith({
    String? username,
    String? FirstName,
    String? tag,
    int? age,
    String? Gender,
    String? profilePicture,
    List<double>? achievementsScores,
    List<CourseInfo>? registeredCourses,
    List<int>? registedCoursesIndexes,
  }) {
    return User(
      username: username ?? this.username,
      fullName: FirstName ?? fullName,
      tag: tag ?? this.tag,
      age: age ?? this.age,
      gender: Gender ?? gender,
      profileImage: profilePicture ?? this.profileImage,
      achievementsProgress: achievementsScores ?? achievementsProgress,
      registeredCourses: registeredCourses ?? this.registeredCourses,
      registedCoursesIndexes:
          registedCoursesIndexes ?? this.registedCoursesIndexes,
    );
  }
}

//In case of error in user input this is the default user info
final User sampleUser = User(
  username: "Mohammad Hammadi",
  fullName: "Mohammad",
  tag: "Software Engineer",
  age: 21,
  gender: "Male",
  profileImage: "https://cdn.wallpapersafari.com/95/19/uFaSYI.jpg",
  achievementsProgress: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  registeredCourses: [],
  registedCoursesIndexes: [],
);
