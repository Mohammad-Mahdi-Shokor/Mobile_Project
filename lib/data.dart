import 'package:flutter/material.dart';

class Course {
  final String title;
  final String Description;
  final List<Lesson> lessons;
  final int NumberOfFinished;
  Course({
    required this.title,
    required this.Description,
    required this.lessons,
    required this.NumberOfFinished,
  });
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

  User({
    required this.username,
    required this.tag,
    required this.age,
    required this.Gender,
    required this.profilePicture,
    required this.achievementsScores,
    required this.registeredCourses,
    required this.FirstName,
  });
}

// the data below is sample data, we will change it later :
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
              Answer(
                answer: "Protecting systems and networks from digital attacks",
              ),
              Answer(answer: "Developing mobile applications"),
              Answer(answer: "Designing computer hardware"),
            ],
          ),
          Question(
            question: "Which of the following is a common cyber attack?",
            answers: [
              Answer(answer: "Phishing"),
              Answer(answer: "Data modeling"),
              Answer(answer: "UI testing"),
            ],
          ),
        ],
      ),
      Lesson(
        title: "Common Types of Attacks",
        Done: false,
        questions: [
          Question(
            question: "What does DDoS stand for?",
            answers: [
              Answer(answer: "Distributed Denial of Service"),
              Answer(answer: "Direct Data Operating System"),
              Answer(answer: "Dynamic Domain of Security"),
            ],
          ),
        ],
      ),
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
  registeredCourses: sampleCourses, // from your previous course sample data
);

List<Achievement> sampleAchievements = [
  Achievement(Icon(Icons.school, color: Colors.blue), "Course 1"),
  Achievement(Icon(Icons.school, color: Colors.green), "Course 2"),
  Achievement(
    Icon(Icons.assignment_turned_in, color: Colors.orange),
    "Assign 1",
  ),
  Achievement(
    Icon(Icons.assignment_turned_in, color: Colors.deepOrange),
    "Assign 2",
  ),
  Achievement(Icon(Icons.emoji_events, color: Colors.amber), "Quiz 1"),
  Achievement(Icon(Icons.ondemand_video, color: Colors.redAccent), "Video 1"),
  Achievement(Icon(Icons.forum, color: Colors.purple), "Forum 1"),
  Achievement(Icon(Icons.star, color: Colors.yellow), "Skill 1"),
  Achievement(Icon(Icons.build, color: Colors.teal), "Project 1"),
  Achievement(Icon(Icons.local_fire_department, color: Colors.red), "Points 1"),
  Achievement(Icon(Icons.whatshot, color: Colors.orangeAccent), "Streak 1"),
  Achievement(Icon(Icons.article, color: Colors.blueGrey), "Reader 1"),
];
