import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/course.dart';

class DatabaseService {
  // Singleton instance
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'courses.db');

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE registeredcourses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        course_index INTEGER NOT NULL
      )
    ''');
  }

  // CRUD Operations
  Future<int> insertCourse(Course course) async {
    Database db = await database;
    return await db.insert('registeredcourses', course.toMap());
  }

  Future<List<Course>> getCourses() async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'registeredcourses',
      orderBy: 'course_index ASC',
    );

    return results.map((map) => Course.fromMap(map)).toList();
  }

  Future<int> updateCourse(Course course) async {
    Database db = await database;
    return await db.update(
      'registeredcourses',
      course.toMap(),
      where: 'id = ?',
      whereArgs: [course.id],
    );
  }

  Future<int> deleteCourse(int id) async {
    Database db = await database;
    return await db.delete(
      'registeredcourses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Additional useful methods
  Future<Course?> getCourseById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'registeredcourses',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (results.isNotEmpty) {
      return Course.fromMap(results.first);
    }
    return null;
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}

class Course {
  int? id;
  final String title;
  final int courseIndex;

  Course({this.id, required this.title, required this.courseIndex});

  // Convert Course object to Map for database operations
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'course_index': courseIndex};
  }

  // Create Course object from Map (database result)
  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      title: map['title'],
      courseIndex: map['course_index'],
    );
  }
}
