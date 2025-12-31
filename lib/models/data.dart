// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class Course {
  final String title;
  final String Description;
  final List<Lesson> lessons;
  final int NumberOfFinished;

  // New fields for course info screen
  final String about;
  final String imageUrl;
  final List<String> sections;

  Course({
    required this.title,
    required this.Description,
    required this.lessons,
    required this.NumberOfFinished,
    required this.about,
    required this.imageUrl,
    required this.sections,
  });
  Course copyWith({
    String? title,
    String? Description,
    List<Lesson>? lessons,
    int? NumberOfFinished,
    String? about,
    String? imageUrl,
    List<String>? sections,
  }) {
    return Course(
      title: title ?? this.title,
      Description: Description ?? this.Description,
      lessons: lessons ?? this.lessons,
      NumberOfFinished: NumberOfFinished ?? this.NumberOfFinished,
      about: about ?? this.about,
      imageUrl: imageUrl ?? this.imageUrl,
      sections: sections ?? this.sections,
    );
  }
}

class Lesson {
  final String title;
  final List<Question> questions;
  final bool Done;

  Lesson({required this.title, required this.questions, required this.Done});
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
}

class User {
  final String username;
  final String FirstName;
  final String tag;
  final int age;
  final String Gender;
  final String profilePicture;
  final List<double> achievementsScores;
  final List<Course> registeredCourses;
  final List<int> registedCoursesIndexes;

  User({
    required this.username,
    required this.tag,
    required this.age,
    required this.Gender,
    required this.profilePicture,
    required this.achievementsScores,
    required this.registeredCourses,
    required this.FirstName,
    required this.registedCoursesIndexes,
  });
}

final List<Course> sampleCourses = [
  Course(
  title: "Cybersecurity",
  Description:
      "Learn the fundamentals of protecting systems, networks, and data.",
  NumberOfFinished: 12,
  lessons: [
    Lesson(
      title: "Introduction to Cybersecurity",
      Done: true,
      questions: [
        Question(
          question: "What is cybersecurity?",
          answers: [
            Answer(answer: "Protecting systems and networks from digital attacks"),
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
      Done: false,
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
            Answer(answer: "Manipulating people to reveal confidential information"),
            Answer(answer: "Encrypting files on a server"),
            Answer(answer: "Upgrading software automatically"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Network Security",
      Done: false,
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
      Done: false,
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
      Done: false,
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
      Done: false,
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
      Done: false,
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
  about:
      "This course introduces the core principles of cybersecurity. You will learn how cyber attacks work, how systems are protected, and why security is essential in the modern digital world.",
  imageUrl: "https://cdn-icons-png.flaticon.com/512/3064/3064197.png",
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

  Course(
    title: "Mobile Development",
    Description:
        "Build modern mobile applications using cross-platform technologies.",
    NumberOfFinished: 7,
    lessons: [
      Lesson(
        title: "Mobile App Basics",
        Done: true,
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
        Done: false,
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
        Done: false,
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
  Course(
    title: "Physics",
    Description:
        "Understand the laws that govern matter, energy, and the universe.",
    NumberOfFinished: 5,
    lessons: [
      Lesson(
        title: "Classical Mechanics",
        Done: true,
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
        Done: false,
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
    about:
        "This course explores the fundamental laws governing matter, energy, and motion, helping you understand how the universe works.",
    imageUrl: "https://cdn-icons-png.flaticon.com/512/2942/2942139.png",
    sections: [
      "Classical Mechanics",
      "Energy & Work",
      "Waves & Motion",
      "Basic Thermodynamics",
    ],
  ),
  Course(
    title: "Philosophy",
    Description:
        "Explore fundamental questions about existence, knowledge, and ethics.",
    NumberOfFinished: 3,
    lessons: [
      Lesson(
        title: "Introduction to Philosophy",
        Done: true,
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
        Done: false,
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
    about:
        "Philosophy encourages critical thinking about life’s deepest questions, including morality, existence, truth, and knowledge.",
    imageUrl: "https://cdn-icons-png.flaticon.com/512/1995/1995574.png",
    sections: [
      "Introduction to Philosophy",
      "Ethics",
      "Metaphysics",
      "Philosophy of Mind",
    ],
  ),
];

final User sampleUser = User(
  username: "Mohammad Hammadi",
  FirstName: "Mohammad",
  tag: "Software Engineer",
  age: 21,
  Gender: "Male",
  profilePicture:
      "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQAqAMBIgACEQEDEQH/xAAaAAEAAgMBAAAAAAAAAAAAAAAABAcDBQYB/8QAORAAAgIBAgIHBwEGBwEAAAAAAAECBAMFEQZREiExQXGBsRMiQmGRodFyFiMyUmLBMzQ1c5Ky8BT/xAAWAQEBAQAAAAAAAAAAAAAAAAAAAQL/xAAWEQEBAQAAAAAAAAAAAAAAAAAAARH/2gAMAwEAAhEDEQA/ALSABpkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARdQv1tOrvNaydCPZFdrk+SRyOocXW809qUIYMfdJrpTf9ijt91zPSt1r+rKXS/+/L9jYUOL7mGSjdhDPj362l0Zfhg13AIun362o11mq5OlHsaa2cXyaJQAAEAAAAAAAAAAAAAAAAAwXbWKlVyWM8toY1u+b5IznIcdXm8mCjF+6l7WfovR/Uo57U9Qz6lblYzv9EN+qC5IiAFQAAEvS9Qz6bbjnrt8pQ36prkyyaVrFdq47OCW+Oa3XNc0/mVWdZwLdftM9Gbbjt7SCfkmvuhVdeADIAAAAAAAAAAAAAAAAeBXfFc3LXrO/wAPRS/4osQrzi3G4a9Yb+JRl9l+ClacAFQAAA23Ck3DXq23xdKL8HFmpNxwnjeTXsH9KlL7MCwwARQAEAAAAAAAAAAAAAAOP46ptZMF2KbTj7Kf1bXq/odgR79PFfp5Kudfu8i28H2p+TKKsBL1PTrGm2pYLMdn1uMu6a5oiFQAAA6vgSp+9sXZLqUfZR+qb9F9Tn9M0/PqdlYK8d3v78n2QXNlkUKeKhTx1sC2hjW3i+9/UipAAIAAAAAAAAAAAAAAAAAAKMNqrgt4Xis4oZIPuktzQWeDqk5OVazlw7/DLaa8u83tq9UqLe1ZxYuSlLrfl2mrzcV6VjbUJ5Mu38sPyBq/2Lyb/wCeht/tvf1Jdbg2pB9KzYy5f6I+4n/c9/bGhvsq9jbntH8mfDxXpeR7Slkxb984Pb7AbirWw1MSxVscceNd0fXx+ZlI9S9UuLerZxZV39GXWvLtJH/uoAACAAAAAAAAAAAAAAAGt1vV8Ok1unLaWafVjx79r5vkiiRqGoVtNw+1tZOgvhj2yk/kjjNU4pu224VZOrif8vXN+L/BqLtzPesysWZ9PI+/sS+SRgLiPZSc25Sbcn2tvrPAAAAA9i3GSlFuMl2ST2aN7pnFF2o1Cy3ZxcpP314Pv8zQgGrR0/UK2o4Pa1Mikl/FF9Uo+KJRVdK5no2I2KuRwyLq+TXJrvRYWh6vh1Wt04roZ4/4uPf+F818iK2QAAAAgAAAAAAAKMF21ipVclnM9oY1v48l5srTUb2XULmSzmfvSfUu6K7kjoON77nnx0MbfRgunk5OT7F9OvzOWKgAAAAAAAAAABJ027m0+5CzgfvR7Y90l3ojAC1KdrFdq47OF7wyR3XNc0zOcbwRfcc2Whkl7s4uePful3rzXodk+0igAIAAAAAAeNqKcpPaK62ekHW8rw6RcyJ7NYpbfQorm7YlbuZrMu3JNy8u77GAAqAAAAAAAAAAAAADPRsOpcwWI9uKaltz5/YtNNSSlF7xfWn8ipSzdEyvNo9PI+14o7+hKqcACAAAAAAGr4n/ANBt/pXqjwAVyADSAAAAAAAAAAAAAAWPwv16DU/Q/wDszwEqtqACAAAP/9k=",
  achievementsScores: [0, 0.1, 0.3, 0.5, 0.7, 1, 1, 1, 1, 1, 1, 1, 1],
  registeredCourses: [
    sampleCourses[0].copyWith(NumberOfFinished: 1),
    sampleCourses[1].copyWith(NumberOfFinished: 2),
  ],
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
