import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// =======================
/// DATABASE HELPER
/// =======================
class DBHelper {
  static final DBHelper instance = DBHelper._internal();
  static Database? _db;

  DBHelper._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'app.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        first_name TEXT,
        tag TEXT,
        age INTEGER,
        gender TEXT,
        profile_picture TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE courses(
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        about TEXT,
        image_url TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE lessons(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        course_id INTEGER,
        title TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE user_courses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        course_id INTEGER,
        finished_lessons INTEGER,
        progress REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE user_lessons(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        lesson_id INTEGER,
        done INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE achievements(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        name TEXT,
        percentage REAL
      )
    ''');
  }
}

/// =======================
/// MODELS
/// =======================

class User {
  final int? id;
  final String username;
  final String firstName;
  final String tag;
  final int age;
  final String gender;
  final String profilePicture;

  User({
    this.id,
    required this.username,
    required this.firstName,
    required this.tag,
    required this.age,
    required this.gender,
    required this.profilePicture,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'username': username,
    'first_name': firstName,
    'tag': tag,
    'age': age,
    'gender': gender,
    'profile_picture': profilePicture,
  };

  factory User.fromMap(Map<String, dynamic> map) => User(
    id: map['id'],
    username: map['username'],
    firstName: map['first_name'],
    tag: map['tag'],
    age: map['age'],
    gender: map['gender'],
    profilePicture: map['profile_picture'],
  );
}

class Course {
  final int id;
  final String title;
  final String description;
  final String about;
  final String imageUrl;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.about,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'about': about,
    'image_url': imageUrl,
  };
}

class Lesson {
  final int? id;
  final int courseId;
  final String title;

  Lesson({this.id, required this.courseId, required this.title});

  Map<String, dynamic> toMap() => {
    'id': id,
    'course_id': courseId,
    'title': title,
  };
}

/// =======================
/// USER OPERATIONS
/// =======================

class UserRepository {
  final dbHelper = DBHelper.instance;

  /// Create User
  Future<int> insertUser(User user) async {
    final db = await dbHelper.database;
    return await db.insert('users', user.toMap());
  }

  /// Update User
  Future<void> updateUser(User user) async {
    final db = await dbHelper.database;
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  /// Get User
  Future<User?> getUser(int id) async {
    final db = await dbHelper.database;
    final res = await db.query('users', where: 'id = ?', whereArgs: [id]);
    if (res.isEmpty) return null;
    return User.fromMap(res.first);
  }
}

/// =======================
/// COURSE & PROGRESS
/// =======================

class CourseRepository {
  final dbHelper = DBHelper.instance;

  Future<void> insertCourse(Course course) async {
    final db = await dbHelper.database;
    await db.insert(
      'courses',
      course.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> registerUserInCourse(int userId, int courseId) async {
    final db = await dbHelper.database;
    await db.insert('user_courses', {
      'user_id': userId,
      'course_id': courseId,
      'finished_lessons': 0,
      'progress': 0.0,
    });
  }

  Future<void> updateProgress(
    int userId,
    int courseId,
    int finished,
    double progress,
  ) async {
    final db = await dbHelper.database;
    await db.update(
      'user_courses',
      {'finished_lessons': finished, 'progress': progress},
      where: 'user_id=? AND course_id=?',
      whereArgs: [userId, courseId],
    );
  }

  Future<List<Map<String, dynamic>>> getUserCourses(int userId) async {
    final db = await dbHelper.database;
    return await db.rawQuery(
      '''
      SELECT courses.*, user_courses.progress, user_courses.finished_lessons
      FROM courses
      JOIN user_courses ON courses.id = user_courses.course_id
      WHERE user_courses.user_id = ?
    ''',
      [userId],
    );
  }
}

/// =======================
/// LESSON PROGRESS
/// =======================

class LessonRepository {
  final dbHelper = DBHelper.instance;

  Future<void> insertLesson(Lesson lesson) async {
    final db = await dbHelper.database;
    await db.insert('lessons', lesson.toMap());
  }

  Future<void> markLessonDone(int userId, int lessonId) async {
    final db = await dbHelper.database;
    await db.insert('user_lessons', {
      'user_id': userId,
      'lesson_id': lessonId,
      'done': 1,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> countFinishedLessons(int userId, int courseId) async {
    final db = await dbHelper.database;
    final res = await db.rawQuery(
      '''
      SELECT COUNT(*) as total
      FROM user_lessons
      JOIN lessons ON lessons.id = user_lessons.lesson_id
      WHERE user_lessons.user_id = ? 
      AND lessons.course_id = ?
      AND user_lessons.done = 1
    ''',
      [userId, courseId],
    );

    return Sqflite.firstIntValue(res) ?? 0;
  }
}
