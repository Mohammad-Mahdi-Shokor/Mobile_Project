import 'package:flutter/material.dart';

import '../services/registered_course.dart';
import 'Question.dart';
import 'achievements.dart';
import 'lesson.dart';

final List<CourseInfo> CoursesInfo = [
  CourseInfo(
    title: "Cybersecurity",
    description:
        "Learn the fundamentals of protecting systems, networks, and data.",
    numberOfFinishedLessons: 0,
    totalLessons: Lessons[0].length,
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

  CourseInfo(
    title: "Mobile Development",
    description:
        "Build modern mobile applications using cross-platform technologies.",
    numberOfFinishedLessons: 0,
    totalLessons: Lessons[1].length,
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

  CourseInfo(
    title: "Physics",
    description:
        "Understand the laws that govern matter, energy, and the universe.",
    numberOfFinishedLessons: 0,
    totalLessons: Lessons[2].length,
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

  CourseInfo(
    title: "Philosophy",
    description:
        "Explore fundamental questions about existence, knowledge, and ethics.",
    numberOfFinishedLessons: 0,
    totalLessons: Lessons[3].length,
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

final List<List<Lesson>> Lessons = [
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

List<Achievement> Achievements = [
  Achievement(
    icon: Icons.school,
    name: "First Step",
    description: "Complete your first lesson",
    progress: 0,
    target: 1,
    type: AchievementType.courseCompletion,
    color: Colors.blue,
  ),
  Achievement(
    icon: Icons.emoji_events,
    name: "Perfect Score",
    description: "Get 100% on any test",
    progress: 0,
    target: 1,
    type: AchievementType.perfectScore,
    color: Colors.amber,
  ),
  Achievement(
    icon: Icons.local_fire_department,
    name: "3-Day Streak",
    description: "Learn for 3 consecutive days",
    progress: 0,
    target: 3,
    type: AchievementType.streak,
    color: Colors.red,
  ),
  Achievement(
    icon: Icons.timer,
    name: "Speed Learner",
    description: "Complete 5 lessons in one day",
    progress: 0,
    target: 5,
    type: AchievementType.speed,
    color: Colors.green,
  ),
  Achievement(
    icon: Icons.trending_up,
    name: "Consistent",
    description: "Complete 10 lessons total",
    progress: 0,
    target: 10,
    type: AchievementType.consistency,
    color: Colors.purple,
  ),
  Achievement(
    icon: Icons.explore,
    name: "Course Explorer",
    description: "Register for 3 different courses",
    progress: 0,
    target: 3,
    type: AchievementType.explorer,
    color: Colors.teal,
  ),
  Achievement(
    icon: Icons.star,
    name: "Master Student",
    description: "Complete all lessons in one course",
    progress: 0,
    target: 1,
    type: AchievementType.master,
    color: Colors.deepOrange,
  ),
  Achievement(
    icon: Icons.people,
    name: "Social Learner",
    description: "Share your progress 5 times",
    progress: 0,
    target: 5,
    type: AchievementType.social,
    color: Colors.indigo,
  ),
  Achievement(
    icon: Icons.lightbulb,
    name: "Quick Thinker",
    description: "Answer 20 questions correctly",
    progress: 0,
    target: 20,
    type: AchievementType.speed,
    color: Colors.cyan,
  ),
  Achievement(
    icon: Icons.rocket_launch,
    name: "Fast Starter",
    description: "Complete first lesson in under 5 minutes",
    progress: 0,
    target: 1,
    type: AchievementType.speed,
    color: Colors.pink,
  ),
  Achievement(
    icon: Icons.done_all,
    name: "Completionist",
    description: "Finish all available courses",
    progress: 0,
    target: CoursesInfo.length,
    type: AchievementType.courseCompletion,
    color: Colors.deepPurple,
  ),
  Achievement(
    icon: Icons.celebration,
    name: "Perfect Week",
    description: "Learn every day for 7 days",
    progress: 0,
    target: 7,
    type: AchievementType.streak,
    color: Colors.orange,
  ),
];
