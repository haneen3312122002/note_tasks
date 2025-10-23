import 'package:notes_tasks/note/data/models/note_model.dart';
import 'package:notes_tasks/note/domain/entities/note_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    String path = join(await getDatabasesPath(), 'app.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,  
            title TEXT,                             
            content TEXT,                           
            date TEXT                               
          )
        ''');
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
    return _database!;
  }

  static Future<int> insertNote(Map<String, dynamic> note) async {
    final db = await getDatabase();
    return await db.insert("notes", note);
  }

  static Future<List<Map<String, dynamic>>> getAllNotes() async {
    final db = await getDatabase();
    return await db.query("notes", orderBy: 'id DESC');
  }

  static Future<int> updateNote(int id, Map<String, dynamic> note) async {
    final db = await getDatabase();
    return await db.update("notes", note, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteNote(int id) async {
    final db = await getDatabase();
    return await db.delete("notes", where: 'id = ?', whereArgs: [id]);
  }

  static Future<Map<String, dynamic>?> getNoteById(int id) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      "notes",
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  static Future<int> insertTask(Map<String, dynamic> task) async {
    final db = await getDatabase();
    return await db.insert("tasks", task);
  }

  static Future<List<Map<String, dynamic>>> getAllTasks() async {
    final db = await getDatabase();
    return await db.query("tasks", orderBy: 'id DESC');
  }

  static Future<int> updateTask(int id, Map<String, dynamic> task) async {
    final db = await getDatabase();
    return await db.update("tasks", task, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteTask(int id) async {
    final db = await getDatabase();
    return await db.delete("tasks", where: 'id = ?', whereArgs: [id]);
  }

  static Future<Map<String, dynamic>?> getTaskById(int id) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
      "tasks",
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }
}
