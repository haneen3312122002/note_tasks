import 'package:notes_tasks/note/data/models/note_model.dart';
import 'package:notes_tasks/note/domain/entities/note_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// A helper class to manage the local SQLite database of the app.
class AppDatabase {
  /// A private static variable to hold the single database instance.
  static Database? _database;

  /// Returns the database instance.
  /// If the database is already initialized, it returns the existing one.
  /// Otherwise, it creates and opens a new database.
  static Future<Database> getDatabase() async {
    // If the database is already created, return it directly.
    if (_database != null) return _database!;

    // Get the default database directory path on the device
    String path = join(await getDatabasesPath(), 'app.db');

    // Open (or create if it doesn't exist) the database at the given path
    _database = await openDatabase(
      path,
      version: 1, // The database schema version
      onCreate: (db, version) async {
        // Called only when the database is created for the first time

        // Create the "notes" table
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,  
            title TEXT,                             
            content TEXT,                           
            date TEXT                               
          )
        ''');

        // Create the "tasks" table
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,  
            title TEXT,                             
            description TEXT,                      
            date TEXT,                              
            status TEXT                             
          )
        ''');
      },
    );

    // Return the initialized database instance
    return _database!;
  }

  //CRUD ----> note
  //create:
  static Future<int> insertNote(Map<String, dynamic> note) async {
    final db = await getDatabase();
    return await db.insert("notes", note);
  }

  //get all notes:
  static Future<List<Map<String, dynamic>>> getAllNotes() async {
    final db = await getDatabase();
    return await db.query("notes", orderBy: 'id DESC');
  }

  //update note:
  static Future<int> updateNote(int id, Map<String, dynamic> note) async {
    final db = await getDatabase();
    return await db.update("notes", note, where: 'id = ?', whereArgs: [id]);
  }

  //delete:
  static Future<int> deleteNote(int id) async {
    final db = await getDatabase();
    return await db.delete("notes", where: 'id = ?', whereArgs: [id]);
  }

  //get note by id:
  static Future<Map<String, dynamic>?> getNoteById(int id) async {
    final db = await getDatabase();

    final List<Map<String, dynamic>> result = await db.query(
      "notes",
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first; // ترجع Map
    } else {
      return null; // لم يتم العثور على الصف
    }
  }

  ///CRUD ----> tasks
  //create task
  static Future<int> insertTask(Map<String, dynamic> task) async {
    final db = await getDatabase();
    return await db.insert("tasks", task);
  }

  //get all tasks
  static Future<List<Map<String, dynamic>>> getAllTasks() async {
    final db = await getDatabase();
    return await db.query("tasks", orderBy: 'id DESC');
  }

  //update task
  static Future<int> updateTask(int id, Map<String, dynamic> task) async {
    final db = await getDatabase();
    return await db.update("tasks", task, where: 'id = ?', whereArgs: [id]);
  }

  //delete task
  static Future<int> deleteTask(int id) async {
    final db = await getDatabase();
    return await db.delete("tasks", where: 'id = ?', whereArgs: [id]);
  }

  //get task by id
  static Future<Map<String, dynamic>?> getTaskById(int id) async {
    final db = await getDatabase();

    final List<Map<String, dynamic>> result = await db.query(
      "tasks",
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first; // ترجع Map
    } else {
      return null; // لم يتم العثور على الصف
    }
  }
}
