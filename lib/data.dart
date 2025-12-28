import 'package:flutter/material.dart';

class Course {
  final String title;
  final String Description;
  final List<Lesson> lessons;
  final bool registered;
  final int NumberOfFinished;
  Course({
    required this.title,
    required this.Description,
    required this.lessons,
    required this.NumberOfFinished,
    required this.registered,
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
  Achievement(this.icon, this.name);
}

// the data below is sample data, we will change it later :
final List<Course> sampleCourses = [
  Course(
    registered: true,
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
    registered: true,
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
    registered: false,
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
    registered: false,
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
