// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../services/registered_course.dart';

// class Course {
//   final String title;
//   final String Description;
//   final List<Lesson> lessons;
//   final int NumberOfFinished;

//   // New fields for course info screen
//   final String about;
//   final String imageUrl;
//   final List<String> sections;

//   Course({
//     required this.title,
//     required this.Description,
//     required this.lessons,
//     required this.NumberOfFinished,
//     required this.about,
//     required this.imageUrl,
//     required this.sections,
//   });
//   Course copyWith({
//     String? title,
//     String? Description,
//     List<Lesson>? lessons,
//     int? NumberOfFinished,
//     String? about,
//     String? imageUrl,
//     List<String>? sections,
//   }) {
//     return Course(
//       title: title ?? this.title,
//       Description: Description ?? this.Description,
//       lessons: lessons ?? this.lessons,
//       NumberOfFinished: NumberOfFinished ?? this.NumberOfFinished,
//       about: about ?? this.about,
//       imageUrl: imageUrl ?? this.imageUrl,
//       sections: sections ?? this.sections,
//     );
//   }
// }

class Lesson {
  final String title;
  final List<Question> questions;
  final bool done; // Changed `Done` to `done` for naming convention consistency
  int get numberOfQuestions => questions.length; // Dynamically calculated
  int numberOfAnswered = 0;

  Lesson({required this.title, required this.questions, required this.done});
}

class Question {
  final String question;
  final List<Answer> answers;

  Question({required this.question, required this.answers});
}

class Answer {
  final String answer;

  Answer({required this.answer});
}

class Achievement {
  final Icon icon;
  final String name;
  final double percentage;
  Achievement(this.icon, this.name, {this.percentage = 0});

  // Convert to Map for SQL insert
  Map<String, dynamic> toMap() {
    return {'name': name, 'percentage': percentage};
  }

  // Convert from SQL to Model
  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      Icon(Icons.star), // Default icon, you can customize this
      map['name'] ?? '',
      percentage: (map['percentage'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

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

// final List<RegisteredCourse> sampleCourses = [
//   RegisteredCourse(
//     title: "Cybersecurity",
//     description:
//         "Learn the fundamentals of protecting systems, networks, and data.",
//     totalLessons: allCourseLessons[0].length,
//     about:
//         "This course introduces the core principles of cybersecurity. You will learn how cyber attacks work, how systems are protected, and why security is essential in the modern digital world.",
//     imageUrl: "https://cdn-icons-png.flaticon.com/512/3064/3064197.png",
//     sections: [
//       "Introduction to Cybersecurity",
//       "Types of Cyber Attacks",
//       "Network Security Basics",
//       "Authentication & Authorization",
//       "Malware & Threats",
//       "Ethical Hacking Overview",
//       "Cybersecurity Best Practices",
//     ],
//     numberOfFinishedLessons: 0,
//   ),

//   RegisteredCourse(
//     title: "Mobile Development",
//     description:
//         "Build modern mobile applications using cross-platform technologies.",
//     numberOfFinishedLessons: 0,
//     about:
//         "Learn how to build modern, beautiful mobile applications using cross-platform technologies. Focus on Flutter and best practices for app development.",
//     imageUrl: "https://cdn-icons-png.flaticon.com/512/1055/1055687.png",
//     sections: [
//       "Mobile App Basics",
//       "Flutter & Dart",
//       "State Management",
//       "UI & UX Principles",
//     ],
//     totalLessons: allCourseLessons[1].length,
//   ),
//   RegisteredCourse(
//     title: "Physics",
//     description:
//         "Understand the laws that govern matter, energy, and the universe.",
//     numberOfFinishedLessons: 0,
//     about:
//         "This course explores the fundamental laws governing matter, energy, and motion, helping you understand how the universe works.",
//     imageUrl: "https://cdn-icons-png.flaticon.com/512/2942/2942139.png",
//     sections: [
//       "Classical Mechanics",
//       "Energy & Work",
//       "Waves & Motion",
//       "Basic Thermodynamics",
//     ],
//     totalLessons: allCourseLessons[2].length,
//   ),
//   RegisteredCourse(
//     title: "Philosophy",
//     description:
//         "Explore fundamental questions about existence, knowledge, and ethics.",
//     numberOfFinishedLessons: 0,
//     about:
//         "Philosophy encourages critical thinking about life’s deepest questions, including morality, existence, truth, and knowledge.",
//     imageUrl: "https://cdn-icons-png.flaticon.com/512/1995/1995574.png",
//     sections: [
//       "Introduction to Philosophy",
//       "Ethics",
//       "Metaphysics",
//       "Philosophy of Mind",
//     ],
//     totalLessons: allCourseLessons[3].length,
//   ),
// ];

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
double iconSize = 30;
List<Achievement> sampleAchievements = [
  Achievement(
    Icon(Icons.school, color: Colors.blue, size: iconSize),
    "Course 1",
  ),
  Achievement(
    Icon(Icons.school, color: Colors.green, size: iconSize),
    "Course 2",
  ),
  Achievement(
    Icon(Icons.assignment_turned_in, color: Colors.orange, size: iconSize),
    "Assign 1",
  ),
  Achievement(
    Icon(Icons.assignment_turned_in, color: Colors.deepOrange, size: iconSize),
    "Assign 2",
  ),
  Achievement(
    Icon(Icons.emoji_events, color: Colors.amber, size: iconSize),
    "Quiz 1",
  ),
  Achievement(
    Icon(Icons.ondemand_video, color: Colors.redAccent, size: iconSize),
    "Video 1",
  ),
  Achievement(
    Icon(Icons.forum, color: Colors.purple, size: iconSize),
    "Forum 1",
  ),
  Achievement(
    Icon(Icons.star, color: Colors.yellow, size: iconSize),
    "Skill 1",
  ),
  Achievement(
    Icon(Icons.build, color: Colors.teal, size: iconSize),
    "Project 1",
  ),
  Achievement(
    Icon(Icons.local_fire_department, color: Colors.red, size: iconSize),
    "Points 1",
  ),
  Achievement(
    Icon(Icons.whatshot, color: Colors.orangeAccent, size: iconSize),
    "Streak 1",
  ),
  Achievement(
    Icon(Icons.article, color: Colors.blueGrey, size: iconSize),
    "Reader 1",
  ),
];

final List<RegisteredCourse> registeredCoursesWithProgress = [
  RegisteredCourse(
    title: "Cybersecurity",
    description:
        "Learn the fundamentals of protecting systems, networks, and data.",
    numberOfFinishedLessons: 0, // Just started
    totalLessons: 7,
    about:
        "This course introduces the core principles of cybersecurity. You will learn how cyber attacks work, how systems are protected, and why security is essential in the modern digital world.",
    imageUrl: "https://cdn-icons-png.freepik.com/512/8460/8460433.png",
    sections: [
      "Introduction to Cybersecurity",
      "Types of Cyber Attacks",
      "Network Security Basics",
      "Authentication & Authorization",
      "Malware & Threats",
      "Ethical Hacking Overview",
      "Cybersecurity Best Practices",
    ],
  ),

  RegisteredCourse(
    title: "Mobile Development",
    description:
        "Build modern mobile applications using cross-platform technologies.",
    numberOfFinishedLessons: 2, // In progress
    totalLessons: 4,
    about:
        "Learn how to build modern, beautiful mobile applications using cross-platform technologies. Focus on Flutter and best practices for app development.",
    imageUrl: "https://cdn-icons-png.flaticon.com/512/1055/1055687.png",
    sections: [
      "Mobile App Basics",
      "Flutter & Dart",
      "State Management",
      "UI & UX Principles",
    ],
  ),

  RegisteredCourse(
    title: "Physics",
    description:
        "Understand the laws that govern matter, energy, and the universe.",
    numberOfFinishedLessons: 4, // Almost complete
    totalLessons: 4,
    about:
        "This course explores the fundamental laws governing matter, energy, and motion, helping you understand how the universe works.",
    imageUrl: "https://cdn-icons-png.flaticon.com/512/1467/1467187.png",
    sections: [
      "Classical Mechanics",
      "Energy & Work",
      "Waves & Motion",
      "Basic Thermodynamics",
    ],
  ),

  RegisteredCourse(
    title: "Philosophy",
    description:
        "Explore fundamental questions about existence, knowledge, and ethics.",
    numberOfFinishedLessons: 0, // Not started yet
    totalLessons: 4,
    about:
        "Philosophy encourages critical thinking about life's deepest questions, including morality, existence, truth, and knowledge.",
    imageUrl: "https://cdn-icons-png.flaticon.com/512/1995/1995574.png",
    sections: [
      "Introduction to Philosophy",
      "Ethics",
      "Metaphysics",
      "Philosophy of Mind",
    ],
  ),
];

final List<List<Lesson>> allCourseLessons = [
  // Course 0: Cybersecurity lessons
  [
    Lesson(
      title: "Introduction to Cybersecurity",
      done: true,
      questions: [
        Question(
          question: "What is cybersecurity?",
          answers: [
            Answer(
              answer: "Protecting systems and networks from digital attacks",
            ),
            Answer(answer: "Developing mobile applications"),
            Answer(answer: "Designing computer hardware"),
          ],
        ),
        Question(
          question: "Why is cybersecurity important?",
          answers: [
            Answer(answer: "To protect sensitive data"),
            Answer(answer: "To speed up computers"),
            Answer(answer: "To improve battery life"),
          ],
        ),
        Question(
          question: "Which of these is part of cybersecurity?",
          answers: [
            Answer(answer: "Network protection"),
            Answer(answer: "Painting software icons"),
            Answer(answer: "Screen resolution adjustment"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Common Types of Attacks",
      done: false,
      questions: [
        Question(
          question: "Which of the following is a common cyber attack?",
          answers: [
            Answer(answer: "Phishing"),
            Answer(answer: "UI Testing"),
            Answer(answer: "Database normalization"),
          ],
        ),
        Question(
          question: "What does ransomware do?",
          answers: [
            Answer(answer: "Locks files until payment is made"),
            Answer(answer: "Deletes temporary files"),
            Answer(answer: "Optimizes system performance"),
          ],
        ),
        Question(
          question: "What is social engineering?",
          answers: [
            Answer(
              answer: "Manipulating people to reveal confidential information",
            ),
            Answer(answer: "Encrypting files on a server"),
            Answer(answer: "Upgrading software automatically"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Network Security",
      done: false,
      questions: [
        Question(
          question: "What is a firewall used for?",
          answers: [
            Answer(answer: "To block unauthorized access"),
            Answer(answer: "To store passwords"),
            Answer(answer: "To run applications faster"),
          ],
        ),
        Question(
          question: "Which protocol secures data over the internet?",
          answers: [
            Answer(answer: "HTTPS"),
            Answer(answer: "HTTP"),
            Answer(answer: "FTP"),
          ],
        ),
        Question(
          question: "What is a VPN used for?",
          answers: [
            Answer(answer: "Secure remote connections"),
            Answer(answer: "Faster downloads"),
            Answer(answer: "Reducing device storage usage"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Authentication & Authorization",
      done: false,
      questions: [
        Question(
          question: "What is multi-factor authentication?",
          answers: [
            Answer(answer: "Using multiple steps to verify identity"),
            Answer(answer: "Logging in once"),
            Answer(answer: "Sharing passwords"),
          ],
        ),
        Question(
          question: "What is the main purpose of authorization?",
          answers: [
            Answer(answer: "Determine access rights"),
            Answer(answer: "Encrypt emails"),
            Answer(answer: "Monitor CPU usage"),
          ],
        ),
        Question(
          question: "Which is a secure password practice?",
          answers: [
            Answer(answer: "Using complex and unique passwords"),
            Answer(answer: "Reusing old passwords"),
            Answer(answer: "Writing passwords on paper"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Malware & Threats",
      done: false,
      questions: [
        Question(
          question: "Which of the following is malware?",
          answers: [
            Answer(answer: "Virus"),
            Answer(answer: "Web browser"),
            Answer(answer: "Spreadsheet"),
          ],
        ),
        Question(
          question: "What is spyware?",
          answers: [
            Answer(answer: "Software that secretly monitors activity"),
            Answer(answer: "A firewall configuration"),
            Answer(answer: "A type of backup software"),
          ],
        ),
        Question(
          question: "What is a zero-day exploit?",
          answers: [
            Answer(answer: "A vulnerability that is unknown to developers"),
            Answer(answer: "A patch for malware"),
            Answer(answer: "A secure login method"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Ethical Hacking Overview",
      done: false,
      questions: [
        Question(
          question: "What is ethical hacking?",
          answers: [
            Answer(answer: "Hacking with permission to test security"),
            Answer(answer: "Hacking for fun"),
            Answer(answer: "Hacking to steal data"),
          ],
        ),
        Question(
          question: "What is a penetration test?",
          answers: [
            Answer(answer: "Testing system vulnerabilities"),
            Answer(answer: "Installing antivirus software"),
            Answer(answer: "Updating operating systems"),
          ],
        ),
        Question(
          question: "Which tool is commonly used in ethical hacking?",
          answers: [
            Answer(answer: "Nmap"),
            Answer(answer: "Word Processor"),
            Answer(answer: "Video Editor"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Cybersecurity Best Practices",
      done: false,
      questions: [
        Question(
          question: "What should you do before clicking a link in an email?",
          answers: [
            Answer(answer: "Verify the sender and URL"),
            Answer(answer: "Click immediately"),
            Answer(answer: "Ignore the email entirely"),
          ],
        ),
        Question(
          question: "What is a safe way to store passwords?",
          answers: [
            Answer(answer: "Use a password manager"),
            Answer(answer: "Write them on sticky notes"),
            Answer(answer: "Reuse the same password"),
          ],
        ),
        Question(
          question: "Why should software be regularly updated?",
          answers: [
            Answer(answer: "To patch security vulnerabilities"),
            Answer(answer: "To slow down the computer"),
            Answer(answer: "To delete user data"),
          ],
        ),
      ],
    ),
  ],

  // Course 1: Mobile Development lessons
  [
    Lesson(
      title: "Mobile App Basics",
      done: true,
      questions: [
        Question(
          question: "What is Flutter mainly used for?",
          answers: [
            Answer(answer: "Building cross-platform mobile apps"),
            Answer(answer: "Creating databases"),
            Answer(answer: "Managing servers"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Native vs Cross Platform",
      done: false,
      questions: [
        Question(
          question: "Which framweork is well known to be cross platform?",
          answers: [
            Answer(answer: "Flutter"),
            Answer(answer: "Wordpress"),
            Answer(answer: "Angular"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "State Management",
      done: false,
      questions: [
        Question(
          question: "Which is a popular state management approach?",
          answers: [
            Answer(answer: "Provider"),
            Answer(answer: "HTTP"),
            Answer(answer: "DNS"),
          ],
        ),
      ],
    ),
  ],

  // Course 2: Physics lessons
  [
    Lesson(
      title: "Classical Mechanics",
      done: true,
      questions: [
        Question(
          question: "What does Newton's First Law describe?",
          answers: [
            Answer(answer: "Inertia"),
            Answer(answer: "Gravity"),
            Answer(answer: "Electric charge"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Energy and Work",
      done: false,
      questions: [
        Question(
          question: "What is the SI unit of energy?",
          answers: [
            Answer(answer: "Joule"),
            Answer(answer: "Watt"),
            Answer(answer: "Newton"),
          ],
        ),
      ],
    ),
  ],

  // Course 3: Philosophy lessons
  [
    Lesson(
      title: "Introduction to Philosophy",
      done: true,
      questions: [
        Question(
          question: "What is philosophy mainly concerned with?",
          answers: [
            Answer(answer: "Questions about existence and knowledge"),
            Answer(answer: "Programming languages"),
            Answer(answer: "Chemical reactions"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Ethics",
      done: false,
      questions: [
        Question(
          question: "Ethics is the study of:",
          answers: [
            Answer(answer: "Moral values and behavior"),
            Answer(answer: "Physical laws"),
            Answer(answer: "Market economies"),
          ],
        ),
      ],
    ),
  ],
];
