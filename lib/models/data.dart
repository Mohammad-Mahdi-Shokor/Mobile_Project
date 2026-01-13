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
              answer: "Protection of systems and data from digital attacks",
            ),
            Answer(answer: "Building physical locks"),
            Answer(answer: "Managing office networks only"),
          ],
        ),
        Question(
          question: "Why is cybersecurity important?",
          answers: [
            Answer(
              answer:
                  "To prevent data breaches and protect sensitive information",
            ),
            Answer(answer: "To make computers faster"),
            Answer(answer: "To reduce electricity costs"),
          ],
        ),
        Question(
          question: "Who can be a target of cyber attacks?",
          answers: [
            Answer(answer: "Individuals, businesses, and governments"),
            Answer(answer: "Only large corporations"),
            Answer(answer: "Only military organizations"),
          ],
        ),
        Question(
          question: "What is a cyber threat?",
          answers: [
            Answer(answer: "Any action that can compromise digital security"),
            Answer(answer: "A verbal warning"),
            Answer(answer: "A type of computer"),
          ],
        ),
        Question(
          question: "Which is a key principle of cybersecurity?",
          answers: [
            Answer(
              answer: "Confidentiality, Integrity, and Availability (CIA)",
            ),
            Answer(answer: "Speed and Efficiency"),
            Answer(answer: "Cost and Performance"),
          ],
        ),
        Question(
          question: "What does 'Confidentiality' mean in cybersecurity?",
          answers: [
            Answer(answer: "Only authorized people can access data"),
            Answer(answer: "Data is always visible"),
            Answer(answer: "Data never changes"),
          ],
        ),
        Question(
          question: "What is 'Integrity' in cybersecurity?",
          answers: [
            Answer(
              answer:
                  "Data remains accurate and unchanged by unauthorized parties",
            ),
            Answer(answer: "Making data public"),
            Answer(answer: "Deleting old data"),
          ],
        ),
        Question(
          question: "What does 'Availability' mean?",
          answers: [
            Answer(answer: "Data and systems are accessible when needed"),
            Answer(answer: "Data is stored in multiple locations"),
            Answer(answer: "Systems never need updates"),
          ],
        ),
        Question(
          question: "What is a vulnerability?",
          answers: [
            Answer(answer: "A weakness that can be exploited by attackers"),
            Answer(answer: "A strong security measure"),
            Answer(answer: "A type of password"),
          ],
        ),
        Question(
          question: "What is risk in cybersecurity?",
          answers: [
            Answer(
              answer: "The probability of a threat exploiting a vulnerability",
            ),
            Answer(answer: "A type of antivirus software"),
            Answer(answer: "A firewall setting"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Types of Cyber Attacks",
      done: false,
      questions: [
        Question(
          question: "What is a phishing attack?",
          answers: [
            Answer(
              answer:
                  "Tricking users into revealing sensitive information via email",
            ),
            Answer(answer: "Catching fish in networks"),
            Answer(answer: "A network fishing protocol"),
          ],
        ),
        Question(
          question: "What does a DDoS attack do?",
          answers: [
            Answer(
              answer: "Overwhelms a system with traffic to make it unavailable",
            ),
            Answer(answer: "Steals login credentials"),
            Answer(answer: "Encrypts user data"),
          ],
        ),
        Question(
          question: "What is malware?",
          answers: [
            Answer(answer: "Software designed to harm or exploit systems"),
            Answer(answer: "A mail delivery system"),
            Answer(answer: "A backup software"),
          ],
        ),
        Question(
          question: "What is ransomware?",
          answers: [
            Answer(
              answer:
                  "Malware that encrypts data and demands payment for decryption",
            ),
            Answer(answer: "A random security update"),
            Answer(answer: "A type of firewall"),
          ],
        ),
        Question(
          question: "What is a man-in-the-middle attack?",
          answers: [
            Answer(answer: "Intercepting communication between two parties"),
            Answer(answer: "Attacking someone in the middle of a room"),
            Answer(answer: "A middleware security tool"),
          ],
        ),
        Question(
          question: "What is SQL injection?",
          answers: [
            Answer(answer: "Inserting malicious SQL code into input fields"),
            Answer(answer: "A database backup method"),
            Answer(answer: "A SQL error message"),
          ],
        ),
        Question(
          question: "What is social engineering?",
          answers: [
            Answer(
              answer:
                  "Manipulating people into divulging confidential information",
            ),
            Answer(answer: "Building social networks"),
            Answer(answer: "Engineering social media platforms"),
          ],
        ),
        Question(
          question: "What is a zero-day vulnerability?",
          answers: [
            Answer(
              answer:
                  "An unknown security flaw exploited before a patch exists",
            ),
            Answer(answer: "A security update released today"),
            Answer(answer: "A vulnerability that lasts one day"),
          ],
        ),
        Question(
          question: "What is credential stuffing?",
          answers: [
            Answer(
              answer: "Using stolen credentials to access multiple accounts",
            ),
            Answer(answer: "Storing passwords in files"),
            Answer(answer: "Creating new user credentials"),
          ],
        ),
        Question(
          question: "What is a brute force attack?",
          answers: [
            Answer(answer: "Trying many password combinations to gain access"),
            Answer(answer: "Using physical force on computers"),
            Answer(answer: "A legitimate security test"),
          ],
        ),
        Question(
          question: "What is spyware?",
          answers: [
            Answer(answer: "Software that secretly monitors user activity"),
            Answer(answer: "Official surveillance software"),
            Answer(answer: "A messaging application"),
          ],
        ),
        Question(
          question: "What is a botnet?",
          answers: [
            Answer(
              answer:
                  "A network of compromised computers controlled by attackers",
            ),
            Answer(answer: "A legitimate bot network"),
            Answer(answer: "A chat application"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Network Security Basics",
      done: false,
      questions: [
        Question(
          question: "What is a firewall?",
          answers: [
            Answer(
              answer:
                  "A security system that monitors and controls network traffic",
            ),
            Answer(answer: "A physical wall in data centers"),
            Answer(answer: "A type of antivirus"),
          ],
        ),
        Question(
          question: "What does encryption do?",
          answers: [
            Answer(
              answer: "Converts data into code to protect confidentiality",
            ),
            Answer(answer: "Deletes sensitive data"),
            Answer(answer: "Compresses files"),
          ],
        ),
        Question(
          question: "What is a VPN?",
          answers: [
            Answer(
              answer:
                  "A virtual private network that encrypts internet connections",
            ),
            Answer(answer: "A very personal network"),
            Answer(answer: "A video privacy notice"),
          ],
        ),
        Question(
          question: "What is a subnet?",
          answers: [
            Answer(
              answer:
                  "A subdivision of a network for organization and security",
            ),
            Answer(answer: "An underwater network"),
            Answer(answer: "A submarine communication system"),
          ],
        ),
        Question(
          question: "What does SSL/TLS do?",
          answers: [
            Answer(answer: "Encrypts data transmitted over the internet"),
            Answer(answer: "Transmits data without encryption"),
            Answer(answer: "Deletes cached data"),
          ],
        ),
        Question(
          question: "What is an intrusion detection system (IDS)?",
          answers: [
            Answer(answer: "Monitors network traffic for suspicious activity"),
            Answer(answer: "Prevents all network connections"),
            Answer(answer: "A type of antivirus software"),
          ],
        ),
        Question(
          question: "What is network segmentation?",
          answers: [
            Answer(
              answer: "Dividing a network into parts to limit lateral movement",
            ),
            Answer(answer: "Breaking a network connection"),
            Answer(answer: "Connecting multiple networks together"),
          ],
        ),
        Question(
          question: "What is a DMZ in networking?",
          answers: [
            Answer(
              answer:
                  "Demilitarized zone between internal network and internet",
            ),
            Answer(answer: "A desert network area"),
            Answer(answer: "A direct mail zone"),
          ],
        ),
        Question(
          question: "What is MAC filtering?",
          answers: [
            Answer(
              answer: "Allowing or blocking devices based on MAC addresses",
            ),
            Answer(answer: "Filtering Apple computers only"),
            Answer(answer: "Machine access control"),
          ],
        ),
        Question(
          question: "What is port scanning?",
          answers: [
            Answer(answer: "Checking which ports are open on a system"),
            Answer(answer: "Opening physical ports"),
            Answer(answer: "Scanning harbor ports"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Authentication & Authorization",
      done: false,
      questions: [
        Question(
          question: "What is authentication?",
          answers: [
            Answer(answer: "Verifying that a user is who they claim to be"),
            Answer(answer: "Giving users permissions"),
            Answer(answer: "Encrypting passwords"),
          ],
        ),
        Question(
          question: "What is authorization?",
          answers: [
            Answer(answer: "Determining what an authenticated user can access"),
            Answer(answer: "Creating new user accounts"),
            Answer(answer: "Verifying user identity"),
          ],
        ),
        Question(
          question: "What is two-factor authentication (2FA)?",
          answers: [
            Answer(
              answer: "Using two verification methods to authenticate a user",
            ),
            Answer(answer: "Two passwords for one account"),
            Answer(answer: "Double encryption of passwords"),
          ],
        ),
        Question(
          question: "What is multi-factor authentication (MFA)?",
          answers: [
            Answer(
              answer: "Using multiple authentication methods simultaneously",
            ),
            Answer(answer: "Multiple passwords"),
            Answer(answer: "Multiple encryption keys"),
          ],
        ),
        Question(
          question: "What is a strong password?",
          answers: [
            Answer(answer: "Long, complex with letters, numbers, and symbols"),
            Answer(answer: "Any password longer than 5 characters"),
            Answer(answer: "A password that's easy to remember"),
          ],
        ),
        Question(
          question: "What is password hashing?",
          answers: [
            Answer(
              answer: "Converting a password into a one-way encrypted value",
            ),
            Answer(answer: "Storing passwords in plain text"),
            Answer(answer: "Sharing passwords securely"),
          ],
        ),
        Question(
          question: "What is a session token?",
          answers: [
            Answer(
              answer:
                  "A temporary credential that allows access during a session",
            ),
            Answer(answer: "A reward for authentication"),
            Answer(answer: "A password reset code"),
          ],
        ),
        Question(
          question: "What is role-based access control (RBAC)?",
          answers: [
            Answer(
              answer:
                  "Granting access based on user roles and responsibilities",
            ),
            Answer(answer: "Giving all users the same access"),
            Answer(answer: "Randomly assigning permissions"),
          ],
        ),
        Question(
          question: "What is biometric authentication?",
          answers: [
            Answer(
              answer:
                  "Using fingerprints or facial recognition for verification",
            ),
            Answer(answer: "Using biological weapons"),
            Answer(answer: "A type of password"),
          ],
        ),
        Question(
          question: "What is Single Sign-On (SSO)?",
          answers: [
            Answer(answer: "One login to access multiple applications"),
            Answer(answer: "Multiple logins for one app"),
            Answer(answer: "A security audit process"),
          ],
        ),
        Question(
          question: "What is privilege escalation?",
          answers: [
            Answer(answer: "Gaining higher access levels than authorized"),
            Answer(answer: "Increasing password strength"),
            Answer(answer: "Promoting a user's role"),
          ],
        ),
        Question(
          question: "What is the principle of least privilege?",
          answers: [
            Answer(
              answer: "Users get minimum necessary permissions for their role",
            ),
            Answer(answer: "Everyone gets admin access"),
            Answer(answer: "Removing all user permissions"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Malware & Threats",
      done: false,
      questions: [
        Question(
          question: "What is a virus?",
          answers: [
            Answer(
              answer: "Malware that replicates by attaching to other programs",
            ),
            Answer(answer: "A biological infection"),
            Answer(answer: "An antivirus software"),
          ],
        ),
        Question(
          question: "What is a worm?",
          answers: [
            Answer(
              answer:
                  "Self-replicating malware that spreads without user interaction",
            ),
            Answer(answer: "An actual worm that damages computers"),
            Answer(answer: "A type of antivirus tool"),
          ],
        ),
        Question(
          question: "What is a trojan horse?",
          answers: [
            Answer(answer: "Malware disguised as legitimate software"),
            Answer(answer: "An ancient siege weapon"),
            Answer(answer: "A security software"),
          ],
        ),
        Question(
          question: "What is a rootkit?",
          answers: [
            Answer(answer: "Malware that provides unauthorized admin access"),
            Answer(answer: "A kit for growing plant roots"),
            Answer(answer: "A security monitoring tool"),
          ],
        ),
        Question(
          question: "What is adware?",
          answers: [
            Answer(answer: "Software that displays unwanted advertisements"),
            Answer(answer: "Legitimate advertising software"),
            Answer(answer: "A web browser tool"),
          ],
        ),
        Question(
          question: "What is a keylogger?",
          answers: [
            Answer(answer: "Malware that records keyboard inputs"),
            Answer(answer: "A logging file for servers"),
            Answer(answer: "A keyboard security feature"),
          ],
        ),
        Question(
          question: "What is a backdoor in malware?",
          answers: [
            Answer(answer: "A hidden entry point for unauthorized access"),
            Answer(answer: "The back of a computer case"),
            Answer(answer: "A security checkpoint"),
          ],
        ),
        Question(
          question: "What is a polymorphic virus?",
          answers: [
            Answer(answer: "A virus that changes its code to evade detection"),
            Answer(answer: "A virus that affects multiple animals"),
            Answer(answer: "A virus with many symptoms"),
          ],
        ),
        Question(
          question: "What is a logic bomb?",
          answers: [
            Answer(
              answer: "Malicious code that executes when conditions are met",
            ),
            Answer(answer: "A bomb that uses logical reasoning"),
            Answer(answer: "A debugging tool"),
          ],
        ),
        Question(
          question: "What is a living off the land attack?",
          answers: [
            Answer(
              answer: "Using legitimate system tools for malicious purposes",
            ),
            Answer(answer: "Hacking while living remotely"),
            Answer(answer: "An environmental attack"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Cybersecurity Best Practices",
      done: false,
      questions: [
        Question(
          question: "What is the importance of regular backups?",
          answers: [
            Answer(
              answer: "To recover data in case of loss or ransomware attacks",
            ),
            Answer(answer: "To speed up computers"),
            Answer(answer: "To reduce storage costs"),
          ],
        ),
        Question(
          question: "What is patch management?",
          answers: [
            Answer(
              answer:
                  "Regularly updating software to fix security vulnerabilities",
            ),
            Answer(answer: "Sewing clothes with patches"),
            Answer(answer: "Creating temporary fixes"),
          ],
        ),
        Question(
          question: "What should you do with old devices?",
          answers: [
            Answer(answer: "Securely wipe data before disposal or recycling"),
            Answer(answer: "Throw them in the trash"),
            Answer(answer: "Leave them in a storage closet"),
          ],
        ),
        Question(
          question: "What is the purpose of security awareness training?",
          answers: [
            Answer(
              answer:
                  "To educate employees about security threats and best practices",
            ),
            Answer(answer: "To entertain office staff"),
            Answer(answer: "To test employee loyalty"),
          ],
        ),
        Question(
          question: "What should you avoid sharing on public WiFi?",
          answers: [
            Answer(
              answer: "Sensitive information like passwords and financial data",
            ),
            Answer(answer: "Social media posts"),
            Answer(answer: "Personal photos"),
          ],
        ),
        Question(
          question: "What is a security audit?",
          answers: [
            Answer(
              answer:
                  "A review of systems and processes to identify vulnerabilities",
            ),
            Answer(answer: "A financial audit with security"),
            Answer(answer: "An internal investigation"),
          ],
        ),
        Question(
          question: "What is incident response?",
          answers: [
            Answer(
              answer:
                  "A plan for handling and recovering from security incidents",
            ),
            Answer(answer: "Responding to customer service incidents"),
            Answer(answer: "Reporting incidents to police"),
          ],
        ),
        Question(
          question: "Why should employees use different passwords?",
          answers: [
            Answer(
              answer:
                  "To prevent attackers from accessing multiple accounts if one is compromised",
            ),
            Answer(answer: "To make systems more secure"),
            Answer(answer: "To test password strength"),
          ],
        ),
        Question(
          question: "What is data classification?",
          answers: [
            Answer(
              answer:
                  "Organizing data by sensitivity level to apply appropriate protections",
            ),
            Answer(answer: "Sorting files alphabetically"),
            Answer(answer: "Deleting unnecessary data"),
          ],
        ),
        Question(
          question: "What should you do if you suspect a phishing email?",
          answers: [
            Answer(
              answer: "Report it to IT/Security without clicking any links",
            ),
            Answer(answer: "Click links to verify authenticity"),
            Answer(answer: "Forward it to all colleagues"),
          ],
        ),
        Question(
          question: "What is the value of a security policy?",
          answers: [
            Answer(
              answer:
                  "It defines rules and procedures to protect information and systems",
            ),
            Answer(answer: "It guarantees complete security"),
            Answer(answer: "It replaces technical security measures"),
          ],
        ),
        Question(
          question: "What is a responsible disclosure program?",
          answers: [
            Answer(
              answer:
                  "A process for reporting vulnerabilities to vendors before public disclosure",
            ),
            Answer(answer: "Publicly announcing all security flaws"),
            Answer(answer: "Keeping vulnerabilities secret"),
          ],
        ),
      ],
    ),
  ],
  // Mobile Development Lessons
  [
    Lesson(
      title: "Mobile App Basics",
      done: false,
      questions: [
        Question(
          question: "What is a mobile application?",
          answers: [
            Answer(answer: "Software designed to run on mobile devices"),
            Answer(answer: "A desktop software"),
            Answer(answer: "A web browser"),
          ],
        ),
        Question(
          question: "What are the main types of mobile apps?",
          answers: [
            Answer(answer: "Native, Web, and Hybrid apps"),
            Answer(answer: "Only native apps exist"),
            Answer(answer: "Desktop and mobile apps"),
          ],
        ),
        Question(
          question: "What is a native mobile app?",
          answers: [
            Answer(
              answer:
                  "An app built specifically for one platform using its native language",
            ),
            Answer(answer: "An app that works on all platforms"),
            Answer(answer: "A web application"),
          ],
        ),
        Question(
          question: "What is a cross-platform mobile app?",
          answers: [
            Answer(
              answer:
                  "An app that runs on multiple platforms with shared codebase",
            ),
            Answer(answer: "An app that only works on iOS"),
            Answer(answer: "An app that needs platform-specific code"),
          ],
        ),
        Question(
          question: "What is the primary advantage of hybrid apps?",
          answers: [
            Answer(answer: "Single codebase for multiple platforms"),
            Answer(answer: "Superior performance compared to native"),
            Answer(answer: "No need for testing"),
          ],
        ),
        Question(
          question: "What is responsive design in mobile apps?",
          answers: [
            Answer(answer: "Design that adapts to different screen sizes"),
            Answer(answer: "Fast loading speed"),
            Answer(answer: "Colorful user interface"),
          ],
        ),
        Question(
          question: "What is mobile app monetization?",
          answers: [
            Answer(answer: "Methods to generate revenue from mobile apps"),
            Answer(answer: "Promoting an app on social media"),
            Answer(answer: "Creating backups of app data"),
          ],
        ),
        Question(
          question: "What does APK stand for?",
          answers: [
            Answer(answer: "Android Package Kit"),
            Answer(answer: "Application Program Kit"),
            Answer(answer: "Advanced Programming Kernel"),
          ],
        ),
        Question(
          question: "What is an app store?",
          answers: [
            Answer(
              answer: "A platform for distributing and downloading mobile apps",
            ),
            Answer(answer: "A physical store selling phones"),
            Answer(answer: "A backup service for apps"),
          ],
        ),
        Question(
          question: "What is user retention in mobile apps?",
          answers: [
            Answer(answer: "Keeping users engaged and coming back to the app"),
            Answer(answer: "Storing user data on the device"),
            Answer(answer: "Backing up user information"),
          ],
        ),
        Question(
          question: "What is a mobile app permission?",
          answers: [
            Answer(
              answer:
                  "Authorization needed to access device resources like camera or location",
            ),
            Answer(answer: "User login credentials"),
            Answer(answer: "A feature restriction"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Flutter & Dart",
      done: false,
      questions: [
        Question(
          question: "What is Flutter?",
          answers: [
            Answer(answer: "A cross-platform mobile framework by Google"),
            Answer(answer: "A native iOS framework"),
            Answer(answer: "A web development tool"),
          ],
        ),
        Question(
          question: "What is Dart?",
          answers: [
            Answer(
              answer:
                  "A programming language created by Google for building apps",
            ),
            Answer(answer: "A game development engine"),
            Answer(answer: "A database management system"),
          ],
        ),
        Question(
          question: "What are widgets in Flutter?",
          answers: [
            Answer(
              answer: "Building blocks that compose the UI of a Flutter app",
            ),
            Answer(answer: "Mobile app icons"),
            Answer(answer: "Database management tools"),
          ],
        ),
        Question(
          question: "What is a StatelessWidget?",
          answers: [
            Answer(
              answer: "A widget that doesn't change state after being created",
            ),
            Answer(answer: "A widget that manages state"),
            Answer(answer: "A temporary widget"),
          ],
        ),
        Question(
          question: "What is a StatefulWidget?",
          answers: [
            Answer(
              answer: "A widget that can change its internal state and rebuild",
            ),
            Answer(answer: "A permanent widget"),
            Answer(answer: "A read-only widget"),
          ],
        ),
        Question(
          question: "What is Hot Reload in Flutter?",
          answers: [
            Answer(
              answer:
                  "A feature that updates code changes instantly without restarting",
            ),
            Answer(answer: "Restarting the app completely"),
            Answer(answer: "Deleting the app cache"),
          ],
        ),
        Question(
          question: "What is the pubspec.yaml file?",
          answers: [
            Answer(
              answer: "A configuration file for Flutter project dependencies",
            ),
            Answer(answer: "A source code file"),
            Answer(answer: "An executable file"),
          ],
        ),
        Question(
          question: "What does 'pub' mean in Flutter?",
          answers: [
            Answer(answer: "Package manager for Dart and Flutter"),
            Answer(answer: "Public library"),
            Answer(answer: "Publishing tool"),
          ],
        ),
        Question(
          question: "What is the main.dart file?",
          answers: [
            Answer(answer: "The entry point of a Flutter application"),
            Answer(answer: "A backup file"),
            Answer(answer: "A configuration file"),
          ],
        ),
        Question(
          question: "What is a Material Design in Flutter?",
          answers: [
            Answer(answer: "Google's design system implemented in Flutter"),
            Answer(answer: "Physical materials used in phones"),
            Answer(answer: "A database design pattern"),
          ],
        ),
        Question(
          question: "What is Cupertino design?",
          answers: [
            Answer(answer: "iOS-style design system in Flutter"),
            Answer(answer: "Android design system"),
            Answer(answer: "Web design system"),
          ],
        ),
        Question(
          question: "What are packages in Flutter?",
          answers: [
            Answer(
              answer:
                  "Reusable code libraries that extend Flutter functionality",
            ),
            Answer(answer: "App distribution formats"),
            Answer(answer: "Device storage units"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "State Management",
      done: false,
      questions: [
        Question(
          question: "What is state management?",
          answers: [
            Answer(answer: "Managing data flow and widget rebuilds in an app"),
            Answer(answer: "Deleting old data"),
            Answer(answer: "Storing passwords"),
          ],
        ),
        Question(
          question: "What is the simplest form of state management in Flutter?",
          answers: [
            Answer(answer: "Using setState() in StatefulWidget"),
            Answer(answer: "Using global variables"),
            Answer(answer: "Storing data in files"),
          ],
        ),
        Question(
          question: "What is the Provider package?",
          answers: [
            Answer(answer: "A popular state management solution for Flutter"),
            Answer(answer: "An internet service provider"),
            Answer(answer: "A data storage tool"),
          ],
        ),
        Question(
          question: "What is BLoC pattern?",
          answers: [
            Answer(
              answer: "A design pattern for separating business logic from UI",
            ),
            Answer(answer: "A block of code"),
            Answer(answer: "A database backup"),
          ],
        ),
        Question(
          question: "What is Riverpod?",
          answers: [
            Answer(
              answer: "A modern state management library for Dart and Flutter",
            ),
            Answer(answer: "A type of river"),
            Answer(answer: "A network protocol"),
          ],
        ),
        Question(
          question: "What is GetX?",
          answers: [
            Answer(
              answer: "A lightweight state management and navigation solution",
            ),
            Answer(answer: "A mathematical function"),
            Answer(answer: "A network request"),
          ],
        ),
        Question(
          question: "What is a notifier in state management?",
          answers: [
            Answer(
              answer: "An object that notifies listeners when state changes",
            ),
            Answer(answer: "A notification service"),
            Answer(answer: "A reminder system"),
          ],
        ),
        Question(
          question: "What is reactive programming?",
          answers: [
            Answer(
              answer:
                  "Programming based on data streams and automatic propagation of changes",
            ),
            Answer(answer: "Responding to user clicks"),
            Answer(answer: "Chemical reactions"),
          ],
        ),
        Question(
          question: "What is a Stream in Dart?",
          answers: [
            Answer(answer: "A sequence of asynchronous data events"),
            Answer(answer: "A river of water"),
            Answer(answer: "A file storage method"),
          ],
        ),
        Question(
          question: "What is a Future in Dart?",
          answers: [
            Answer(
              answer:
                  "A representation of a value that may not be available yet",
            ),
            Answer(answer: "A prediction of tomorrow"),
            Answer(answer: "A scheduling tool"),
          ],
        ),
        Question(
          question: "Why is proper state management important?",
          answers: [
            Answer(
              answer: "It makes code maintainable, scalable, and prevents bugs",
            ),
            Answer(answer: "To make apps faster"),
            Answer(answer: "To reduce app size"),
          ],
        ),
        Question(
          question: "What is the context in Flutter?",
          answers: [
            Answer(
              answer: "A reference to the widget tree location and theme data",
            ),
            Answer(answer: "User context or information"),
            Answer(answer: "A database connection"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "UI & UX Principles",
      done: false,
      questions: [
        Question(
          question: "What is UI design?",
          answers: [
            Answer(answer: "Designing the visual elements users interact with"),
            Answer(answer: "Writing user interface code"),
            Answer(answer: "Creating database schemas"),
          ],
        ),
        Question(
          question: "What is UX design?",
          answers: [
            Answer(
              answer: "Designing the overall user experience and satisfaction",
            ),
            Answer(answer: "Making apps visually appealing"),
            Answer(answer: "Writing documentation"),
          ],
        ),
        Question(
          question: "What is the principle of consistency?",
          answers: [
            Answer(
              answer:
                  "Using consistent design patterns and behaviors throughout the app",
            ),
            Answer(answer: "Using only one color"),
            Answer(answer: "Never changing the design"),
          ],
        ),
        Question(
          question: "What is user feedback in UX?",
          answers: [
            Answer(answer: "Visual or audio responses to user actions"),
            Answer(answer: "Comments from users"),
            Answer(answer: "Survey responses"),
          ],
        ),
        Question(
          question: "What is accessibility in mobile apps?",
          answers: [
            Answer(answer: "Designing apps usable by people with disabilities"),
            Answer(answer: "Making apps available offline"),
            Answer(answer: "Fast app loading"),
          ],
        ),
        Question(
          question: "What is whitespace in UI design?",
          answers: [
            Answer(answer: "Empty space used to improve readability and focus"),
            Answer(answer: "Unused device memory"),
            Answer(answer: "A color option"),
          ],
        ),
        Question(
          question: "What is a user persona?",
          answers: [
            Answer(answer: "A fictional representation of target users"),
            Answer(answer: "A user's personality type"),
            Answer(answer: "A user account profile"),
          ],
        ),
        Question(
          question: "What is user research?",
          answers: [
            Answer(
              answer: "Understanding user needs, behaviors, and pain points",
            ),
            Answer(answer: "Surveying app ratings"),
            Answer(answer: "Testing app performance"),
          ],
        ),
        Question(
          question: "What is responsive design?",
          answers: [
            Answer(answer: "Design that works well on different screen sizes"),
            Answer(answer: "Fast responding apps"),
            Answer(answer: "Apps that respond to voice commands"),
          ],
        ),
        Question(
          question: "What is navigation in UX?",
          answers: [
            Answer(
              answer: "How users move between screens and find information",
            ),
            Answer(answer: "GPS tracking"),
            Answer(answer: "App menu design only"),
          ],
        ),
        Question(
          question: "What is the gestalt principle in design?",
          answers: [
            Answer(answer: "Organizing elements into meaningful groups"),
            Answer(answer: "Using large fonts"),
            Answer(answer: "Applying animations"),
          ],
        ),
        Question(
          question: "What is a wireframe?",
          answers: [
            Answer(answer: "A low-fidelity sketch of app layout and structure"),
            Answer(answer: "A final UI design"),
            Answer(answer: "A circuit board"),
          ],
        ),
      ],
    ),
  ],

  // Physics Lessons
  [
    Lesson(
      title: "Classical Mechanics",
      done: false,
      questions: [
        Question(
          question: "What is classical mechanics?",
          answers: [
            Answer(
              answer: "The study of motion and forces of macroscopic objects",
            ),
            Answer(answer: "The study of quantum particles"),
            Answer(answer: "The study of electricity"),
          ],
        ),
        Question(
          question: "What is Newton's first law of motion?",
          answers: [
            Answer(
              answer:
                  "An object at rest stays at rest unless acted upon by force",
            ),
            Answer(answer: "Force equals mass times acceleration"),
            Answer(answer: "Action and reaction are equal"),
          ],
        ),
        Question(
          question: "What is Newton's second law?",
          answers: [
            Answer(answer: "Force equals mass times acceleration (F=ma)"),
            Answer(answer: "Objects move in straight lines"),
            Answer(answer: "Momentum is conserved"),
          ],
        ),
        Question(
          question: "What is Newton's third law?",
          answers: [
            Answer(
              answer:
                  "For every action, there is an equal and opposite reaction",
            ),
            Answer(answer: "Objects fall at the same speed"),
            Answer(answer: "Energy cannot be created or destroyed"),
          ],
        ),
        Question(
          question: "What is velocity?",
          answers: [
            Answer(answer: "The rate of change of position with direction"),
            Answer(answer: "The speed of an object"),
            Answer(answer: "The distance traveled"),
          ],
        ),
        Question(
          question: "What is acceleration?",
          answers: [
            Answer(answer: "The rate of change of velocity"),
            Answer(answer: "The speed of an object"),
            Answer(answer: "The distance covered"),
          ],
        ),
        Question(
          question: "What is friction?",
          answers: [
            Answer(answer: "A force that opposes motion between surfaces"),
            Answer(answer: "Heat generated by motion"),
            Answer(answer: "A type of energy"),
          ],
        ),
        Question(
          question: "What is gravitational force?",
          answers: [
            Answer(answer: "The attractive force between masses"),
            Answer(answer: "The force that stops motion"),
            Answer(answer: "The force that creates heat"),
          ],
        ),
        Question(
          question: "What is kinematics?",
          answers: [
            Answer(answer: "The study of motion without considering forces"),
            Answer(answer: "The study of forces"),
            Answer(answer: "The study of energy"),
          ],
        ),
        Question(
          question: "What is dynamics?",
          answers: [
            Answer(answer: "The study of forces and how they cause motion"),
            Answer(answer: "The study of stationary objects"),
            Answer(answer: "The study of heat"),
          ],
        ),
        Question(
          question: "What is centripetal force?",
          answers: [
            Answer(
              answer: "Force directed toward the center of circular motion",
            ),
            Answer(answer: "Force away from the center"),
            Answer(answer: "Force in straight line motion"),
          ],
        ),
        Question(
          question: "What is angular momentum?",
          answers: [
            Answer(answer: "A measure of rotational motion"),
            Answer(answer: "Linear movement speed"),
            Answer(answer: "Circular velocity"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Energy & Work",
      done: false,
      questions: [
        Question(
          question: "What is work in physics?",
          answers: [
            Answer(
              answer: "Force applied over a distance in the direction of force",
            ),
            Answer(answer: "The amount of effort applied"),
            Answer(answer: "Heat produced by friction"),
          ],
        ),
        Question(
          question: "What is kinetic energy?",
          answers: [
            Answer(answer: "Energy of motion"),
            Answer(answer: "Energy stored in objects"),
            Answer(answer: "Heat energy"),
          ],
        ),
        Question(
          question: "What is potential energy?",
          answers: [
            Answer(answer: "Energy stored due to position or configuration"),
            Answer(answer: "Energy being used"),
            Answer(answer: "Wasted energy"),
          ],
        ),
        Question(
          question: "What is the law of conservation of energy?",
          answers: [
            Answer(
              answer: "Energy cannot be created or destroyed, only transformed",
            ),
            Answer(answer: "Energy always decreases"),
            Answer(answer: "Energy stays constant in isolated systems"),
          ],
        ),
        Question(
          question: "What is mechanical energy?",
          answers: [
            Answer(answer: "Sum of kinetic and potential energy"),
            Answer(answer: "Energy from machines"),
            Answer(answer: "Electrical energy"),
          ],
        ),
        Question(
          question: "What is gravitational potential energy?",
          answers: [
            Answer(
              answer:
                  "Energy due to an object's height in a gravitational field",
            ),
            Answer(answer: "Energy of falling objects"),
            Answer(answer: "Energy at ground level"),
          ],
        ),
        Question(
          question: "What is elastic potential energy?",
          answers: [
            Answer(
              answer:
                  "Energy stored in stretched or compressed elastic materials",
            ),
            Answer(answer: "Energy of rubber balls"),
            Answer(answer: "Energy in springs at rest"),
          ],
        ),
        Question(
          question: "What is power?",
          answers: [
            Answer(answer: "The rate at which work is done"),
            Answer(answer: "The amount of force applied"),
            Answer(answer: "The distance traveled"),
          ],
        ),
        Question(
          question: "What is efficiency in energy?",
          answers: [
            Answer(
              answer: "Percentage of input energy converted to useful output",
            ),
            Answer(answer: "Total energy available"),
            Answer(answer: "Speed of energy transfer"),
          ],
        ),
        Question(
          question: "What is heat?",
          answers: [
            Answer(answer: "Transfer of thermal energy between objects"),
            Answer(answer: "High temperature"),
            Answer(answer: "Energy from the sun"),
          ],
        ),
        Question(
          question: "What is the work-energy theorem?",
          answers: [
            Answer(answer: "Work done equals change in kinetic energy"),
            Answer(answer: "Work equals force times distance"),
            Answer(answer: "All energy is converted to work"),
          ],
        ),
        Question(
          question: "What is renewable energy?",
          answers: [
            Answer(
              answer: "Energy from sources that can be replenished naturally",
            ),
            Answer(answer: "Energy from fossil fuels"),
            Answer(answer: "Energy stored in batteries"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Waves & Motion",
      done: false,
      questions: [
        Question(
          question: "What is a wave?",
          answers: [
            Answer(
              answer:
                  "A disturbance that travels through space and transfers energy",
            ),
            Answer(answer: "Water moving in the ocean"),
            Answer(answer: "A type of vibration"),
          ],
        ),
        Question(
          question: "What is wavelength?",
          answers: [
            Answer(answer: "The distance between consecutive wave crests"),
            Answer(answer: "The height of a wave"),
            Answer(answer: "The speed of a wave"),
          ],
        ),
        Question(
          question: "What is frequency?",
          answers: [
            Answer(answer: "The number of waves passing a point per unit time"),
            Answer(answer: "The distance of a wave"),
            Answer(answer: "The amplitude of a wave"),
          ],
        ),
        Question(
          question: "What is amplitude?",
          answers: [
            Answer(
              answer:
                  "The maximum displacement of a wave from its rest position",
            ),
            Answer(answer: "The wavelength"),
            Answer(answer: "The frequency"),
          ],
        ),
        Question(
          question: "What are transverse waves?",
          answers: [
            Answer(
              answer:
                  "Waves where particles oscillate perpendicular to wave direction",
            ),
            Answer(answer: "Waves that don't move"),
            Answer(answer: "Waves parallel to motion"),
          ],
        ),
        Question(
          question: "What are longitudinal waves?",
          answers: [
            Answer(
              answer:
                  "Waves where particles oscillate parallel to wave direction",
            ),
            Answer(answer: "Waves that move slowly"),
            Answer(answer: "Waves perpendicular to motion"),
          ],
        ),
        Question(
          question: "What is the Doppler effect?",
          answers: [
            Answer(answer: "Change in wave frequency due to relative motion"),
            Answer(answer: "Waves bouncing off surfaces"),
            Answer(answer: "Wave interference"),
          ],
        ),
        Question(
          question: "What is interference?",
          answers: [
            Answer(
              answer:
                  "Superposition of waves resulting in constructive or destructive effects",
            ),
            Answer(answer: "Waves stopping suddenly"),
            Answer(answer: "Waves changing direction"),
          ],
        ),
        Question(
          question: "What is diffraction?",
          answers: [
            Answer(answer: "Bending of waves around obstacles"),
            Answer(answer: "Waves speeding up"),
            Answer(answer: "Waves combining"),
          ],
        ),
        Question(
          question: "What is resonance?",
          answers: [
            Answer(
              answer:
                  "Oscillation at maximum amplitude when frequency matches natural frequency",
            ),
            Answer(answer: "All waves are equal"),
            Answer(answer: "Waves disappear"),
          ],
        ),
        Question(
          question: "What is sound?",
          answers: [
            Answer(answer: "A longitudinal wave that travels through media"),
            Answer(answer: "Vibrations in the air only"),
            Answer(answer: "Light waves"),
          ],
        ),
        Question(
          question: "What is the speed of light?",
          answers: [
            Answer(answer: "Approximately 3 × 10^8 meters per second"),
            Answer(answer: "The speed of sound"),
            Answer(answer: "Constant everywhere"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Basic Thermodynamics",
      done: false,
      questions: [
        Question(
          question: "What is thermodynamics?",
          answers: [
            Answer(
              answer: "The study of heat, temperature, and energy transfer",
            ),
            Answer(answer: "The study of motion"),
            Answer(answer: "The study of electricity"),
          ],
        ),
        Question(
          question: "What is temperature?",
          answers: [
            Answer(answer: "A measure of average kinetic energy of particles"),
            Answer(answer: "The amount of heat"),
            Answer(answer: "Energy transfer"),
          ],
        ),
        Question(
          question: "What is the first law of thermodynamics?",
          answers: [
            Answer(answer: "Energy is conserved; ΔU = Q - W"),
            Answer(answer: "Heat flows from hot to cold"),
            Answer(answer: "Entropy always decreases"),
          ],
        ),
        Question(
          question: "What is the second law of thermodynamics?",
          answers: [
            Answer(answer: "Entropy of isolated systems always increases"),
            Answer(answer: "Heat cannot be created"),
            Answer(answer: "Temperature is constant"),
          ],
        ),
        Question(
          question: "What is entropy?",
          answers: [
            Answer(answer: "A measure of disorder or randomness in a system"),
            Answer(answer: "Heat content"),
            Answer(answer: "Temperature difference"),
          ],
        ),
        Question(
          question: "What is specific heat capacity?",
          answers: [
            Answer(answer: "Energy needed to raise 1 kg of substance by 1°C"),
            Answer(answer: "Total heat in an object"),
            Answer(answer: "Rate of cooling"),
          ],
        ),
        Question(
          question: "What is latent heat?",
          answers: [
            Answer(
              answer:
                  "Energy required for phase change without temperature change",
            ),
            Answer(answer: "Hidden heat in objects"),
            Answer(answer: "Temperature increase"),
          ],
        ),
        Question(
          question: "What is conduction?",
          answers: [
            Answer(answer: "Heat transfer through direct contact"),
            Answer(answer: "Heat transfer through air"),
            Answer(answer: "Heat transfer by radiation"),
          ],
        ),
        Question(
          question: "What is convection?",
          answers: [
            Answer(answer: "Heat transfer through fluid movement"),
            Answer(answer: "Heat transfer through solids"),
            Answer(answer: "Heat transfer by radiation"),
          ],
        ),
        Question(
          question: "What is radiation?",
          answers: [
            Answer(answer: "Heat transfer through electromagnetic waves"),
            Answer(answer: "Heat transfer by movement"),
            Answer(answer: "Heat transfer by contact"),
          ],
        ),
        Question(
          question: "What is the Carnot cycle?",
          answers: [
            Answer(
              answer: "A theoretical heat engine cycle with maximum efficiency",
            ),
            Answer(answer: "A circular motion"),
            Answer(answer: "A temperature change"),
          ],
        ),
        Question(
          question: "What is absolute zero?",
          answers: [
            Answer(
              answer: "The lowest possible temperature: -273.15°C or 0 Kelvin",
            ),
            Answer(answer: "Freezing point of water"),
            Answer(answer: "Room temperature"),
          ],
        ),
      ],
    ),
  ],

  // Philosophy Lessons
  [
    Lesson(
      title: "Introduction to Philosophy",
      done: false,
      questions: [
        Question(
          question: "What is philosophy?",
          answers: [
            Answer(
              answer:
                  "The love of wisdom and critical examination of fundamental questions",
            ),
            Answer(answer: "A religious practice"),
            Answer(answer: "A scientific discipline"),
          ],
        ),
        Question(
          question: "What is epistemology?",
          answers: [
            Answer(answer: "The study of knowledge and how we know things"),
            Answer(answer: "The study of existence"),
            Answer(answer: "The study of beauty"),
          ],
        ),
        Question(
          question: "What is metaphysics?",
          answers: [
            Answer(answer: "The study of reality and existence"),
            Answer(answer: "The study of knowledge"),
            Answer(answer: "The study of physical objects"),
          ],
        ),
        Question(
          question: "What is logic?",
          answers: [
            Answer(answer: "The study of reasoning and valid arguments"),
            Answer(answer: "A way of thinking"),
            Answer(answer: "Mathematical computation"),
          ],
        ),
        Question(
          question: "What is aesthetics in philosophy?",
          answers: [
            Answer(answer: "The study of beauty, art, and taste"),
            Answer(answer: "The study of appearance"),
            Answer(answer: "The study of colors"),
          ],
        ),
        Question(
          question: "What is a philosophical argument?",
          answers: [
            Answer(
              answer: "A set of premises presented to support a conclusion",
            ),
            Answer(answer: "A debate between people"),
            Answer(answer: "A disagreement"),
          ],
        ),
        Question(
          question: "What does it mean to think critically?",
          answers: [
            Answer(answer: "To analyze information and arguments carefully"),
            Answer(answer: "To criticize everything"),
            Answer(answer: "To disagree with others"),
          ],
        ),
        Question(
          question: "What is the Socratic method?",
          answers: [
            Answer(
              answer: "A dialogue method using questions to examine beliefs",
            ),
            Answer(answer: "A type of argument"),
            Answer(answer: "A teaching technique"),
          ],
        ),
        Question(
          question: "What is a fallacy?",
          answers: [
            Answer(answer: "An error in reasoning or an invalid argument"),
            Answer(answer: "A false statement"),
            Answer(answer: "An incorrect fact"),
          ],
        ),
        Question(
          question: "What is existentialism?",
          answers: [
            Answer(
              answer:
                  "A philosophy emphasizing individual existence and freedom",
            ),
            Answer(answer: "The belief that everything exists"),
            Answer(answer: "A study of emotions"),
          ],
        ),
        Question(
          question: "What is rationalism?",
          answers: [
            Answer(
              answer:
                  "The belief that reason is the primary source of knowledge",
            ),
            Answer(answer: "Being practical and logical"),
            Answer(answer: "A mathematical approach"),
          ],
        ),
        Question(
          question: "What is empiricism?",
          answers: [
            Answer(
              answer:
                  "The belief that experience and observation are primary sources of knowledge",
            ),
            Answer(answer: "Relying on experiments only"),
            Answer(answer: "A scientific method"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Ethics",
      done: false,
      questions: [
        Question(
          question: "What is ethics?",
          answers: [
            Answer(
              answer:
                  "The philosophical study of right and wrong, good and bad",
            ),
            Answer(answer: "Following rules and regulations"),
            Answer(answer: "Being a good person"),
          ],
        ),
        Question(
          question: "What is utilitarianism?",
          answers: [
            Answer(
              answer:
                  "An ethical theory that maximizes overall happiness or well-being",
            ),
            Answer(answer: "Using things for practical purposes"),
            Answer(answer: "Being efficient"),
          ],
        ),
        Question(
          question: "What is deontology?",
          answers: [
            Answer(answer: "An ethical theory based on duties and rules"),
            Answer(answer: "A study of obligations"),
            Answer(answer: "Following laws"),
          ],
        ),
        Question(
          question: "What is virtue ethics?",
          answers: [
            Answer(
              answer: "An ethical theory focusing on character and virtues",
            ),
            Answer(answer: "Being virtuous"),
            Answer(answer: "Following moral codes"),
          ],
        ),
        Question(
          question: "What is the categorical imperative?",
          answers: [
            Answer(
              answer: "Kant's principle to act only on universalizable maxims",
            ),
            Answer(answer: "An absolute rule"),
            Answer(answer: "A strict order"),
          ],
        ),
        Question(
          question: "What is consequentialism?",
          answers: [
            Answer(
              answer: "A theory that judges actions by their consequences",
            ),
            Answer(answer: "Following consequences"),
            Answer(answer: "Planning for the future"),
          ],
        ),
        Question(
          question: "What is relativism?",
          answers: [
            Answer(
              answer: "The view that morality is not absolute but relative",
            ),
            Answer(answer: "Believing in Einstein's theories"),
            Answer(answer: "Having flexible standards"),
          ],
        ),
        Question(
          question: "What is objectivism?",
          answers: [
            Answer(
              answer:
                  "The view that morality is objective and independent of opinion",
            ),
            Answer(answer: "Being objective in judgment"),
            Answer(answer: "Treating things as objects"),
          ],
        ),
        Question(
          question: "What is the golden rule?",
          answers: [
            Answer(answer: "Treat others as you want to be treated"),
            Answer(answer: "A rule made of gold"),
            Answer(answer: "The most important rule"),
          ],
        ),
        Question(
          question: "What is moral responsibility?",
          answers: [
            Answer(
              answer:
                  "The idea that people are accountable for their moral actions",
            ),
            Answer(answer: "Responsible behavior"),
            Answer(answer: "Following ethics"),
          ],
        ),
        Question(
          question: "What is justice?",
          answers: [
            Answer(
              answer: "The principle of fair treatment and proper distribution",
            ),
            Answer(answer: "Following laws"),
            Answer(answer: "Punishment for crimes"),
          ],
        ),
        Question(
          question: "What is virtue?",
          answers: [
            Answer(answer: "A good quality of character"),
            Answer(answer: "Being virtuous"),
            Answer(answer: "A moral rule"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Metaphysics",
      done: false,
      questions: [
        Question(
          question: "What is metaphysics?",
          answers: [
            Answer(
              answer:
                  "The study of reality, existence, and the nature of being",
            ),
            Answer(answer: "A mystical practice"),
            Answer(answer: "The study of the physical world"),
          ],
        ),
        Question(
          question: "What is ontology?",
          answers: [
            Answer(answer: "The philosophical study of being and existence"),
            Answer(answer: "The science of names"),
            Answer(answer: "The study of biology"),
          ],
        ),
        Question(
          question: "What is the mind-body problem?",
          answers: [
            Answer(
              answer: "The philosophical question of how mind and body relate",
            ),
            Answer(answer: "Mental and physical health"),
            Answer(answer: "Consciousness"),
          ],
        ),
        Question(
          question: "What is dualism?",
          answers: [
            Answer(
              answer: "The view that mind and body are two distinct substances",
            ),
            Answer(answer: "Having two options"),
            Answer(answer: "Division into two parts"),
          ],
        ),
        Question(
          question: "What is materialism?",
          answers: [
            Answer(
              answer: "The view that physical matter is fundamental reality",
            ),
            Answer(answer: "Desiring material possessions"),
            Answer(answer: "The study of materials"),
          ],
        ),
        Question(
          question: "What is free will?",
          answers: [
            Answer(
              answer:
                  "The ability to make choices not predetermined by prior causes",
            ),
            Answer(answer: "Freedom from restrictions"),
            Answer(answer: "Making independent decisions"),
          ],
        ),
        Question(
          question: "What is determinism?",
          answers: [
            Answer(
              answer: "The view that all events are determined by prior causes",
            ),
            Answer(answer: "Being determined"),
            Answer(answer: "Planning ahead"),
          ],
        ),
        Question(
          question: "What is causation?",
          answers: [
            Answer(answer: "The relationship between cause and effect"),
            Answer(answer: "A reason for something"),
            Answer(answer: "A result of action"),
          ],
        ),
        Question(
          question: "What is substance?",
          answers: [
            Answer(
              answer: "In metaphysics, something that exists independently",
            ),
            Answer(answer: "Physical matter"),
            Answer(answer: "Important things"),
          ],
        ),
        Question(
          question: "What are universals?",
          answers: [
            Answer(answer: "Abstract entities representing shared properties"),
            Answer(answer: "Things found everywhere"),
            Answer(answer: "General concepts"),
          ],
        ),
        Question(
          question: "What is nominalism?",
          answers: [
            Answer(
              answer:
                  "The view that only concrete particulars exist, not universals",
            ),
            Answer(answer: "Names and naming"),
            Answer(answer: "Nominal amounts"),
          ],
        ),
        Question(
          question: "What is possible worlds theory?",
          answers: [
            Answer(
              answer:
                  "The philosophical framework about possible ways reality could be",
            ),
            Answer(answer: "Alternative futures"),
            Answer(answer: "Fictional worlds"),
          ],
        ),
      ],
    ),
    Lesson(
      title: "Philosophy of Mind",
      done: false,
      questions: [
        Question(
          question: "What is the philosophy of mind?",
          answers: [
            Answer(
              answer:
                  "The study of consciousness, mental states, and perception",
            ),
            Answer(answer: "Understanding how minds work"),
            Answer(answer: "Psychology"),
          ],
        ),
        Question(
          question: "What is consciousness?",
          answers: [
            Answer(
              answer:
                  "Subjective experience and awareness of thoughts and sensations",
            ),
            Answer(answer: "Being awake"),
            Answer(answer: "Thinking"),
          ],
        ),
        Question(
          question: "What is the hard problem of consciousness?",
          answers: [
            Answer(
              answer:
                  "Why subjective experience arises from physical processes",
            ),
            Answer(answer: "Understanding brain function"),
            Answer(answer: "Studying difficult concepts"),
          ],
        ),
        Question(
          question: "What is qualia?",
          answers: [
            Answer(answer: "The subjective qualities of conscious experiences"),
            Answer(answer: "Different types of things"),
            Answer(answer: "Qualities in general"),
          ],
        ),
        Question(
          question: "What is the zombie argument?",
          answers: [
            Answer(
              answer:
                  "A thought experiment about beings physically identical but not conscious",
            ),
            Answer(answer: "A horror movie concept"),
            Answer(answer: "A science fiction idea"),
          ],
        ),
        Question(
          question: "What is functionalism?",
          answers: [
            Answer(
              answer:
                  "The view that mental states are defined by their functional roles",
            ),
            Answer(answer: "Being functional"),
            Answer(answer: "Focusing on function"),
          ],
        ),
        Question(
          question: "What is intentionality?",
          answers: [
            Answer(
              answer: "The property of mental states being about something",
            ),
            Answer(answer: "Doing things on purpose"),
            Answer(answer: "Deliberate action"),
          ],
        ),
        Question(
          question: "What is perception?",
          answers: [
            Answer(answer: "The process of acquiring sensory information"),
            Answer(answer: "What you see"),
            Answer(answer: "Understanding things"),
          ],
        ),
        Question(
          question: "What is the knowledge argument?",
          answers: [
            Answer(
              answer:
                  "Mary's Room thought experiment about physical knowledge and subjective experience",
            ),
            Answer(answer: "Arguments about knowledge"),
            Answer(answer: "Philosophical debate"),
          ],
        ),
        Question(
          question: "What is artificial intelligence in philosophy?",
          answers: [
            Answer(
              answer:
                  "The philosophical question of whether machines can have minds",
            ),
            Answer(answer: "Computer programs"),
            Answer(answer: "Technology"),
          ],
        ),
        Question(
          question: "What is the Chinese Room argument?",
          answers: [
            Answer(
              answer:
                  "Searle's argument that syntax is insufficient for understanding",
            ),
            Answer(answer: "Understanding Chinese"),
            Answer(answer: "Translation theory"),
          ],
        ),
        Question(
          question: "What is personal identity?",
          answers: [
            Answer(answer: "What makes a person the same person over time"),
            Answer(answer: "Personal characteristics"),
            Answer(answer: "Individual traits"),
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
