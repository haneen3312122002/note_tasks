// note_datasource.dart
import 'package:notes_tasks/core/database.dart';
import '../models/note_model.dart';
import '../../domain/entities/note_entity.dart';

class NoteDataSource {
  Future<int> insertNote(NoteEntity note) async {
    final model = NoteModel(
      //entity ----> model ----> map
      id: note.id,
      title: note.title,
      content: note.content,
      date: note.date,
    );
    return await AppDatabase.insertNote(model.toMap());
  }

  Future<List<NoteModel>> getAllNotes() async {
    //list of maps ---> list of entities
    final List<Map<String, dynamic>> maps = await AppDatabase.getAllNotes();
    return maps.map((map) => NoteModel.fromMap(map)).toList();
  }

  // AppDatabase
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

  Future<int> updateNote(NoteEntity note) async {
    //entity ---> model ---> map
    final model = NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      date: note.date,
    );
    return await AppDatabase.updateNote(note.id!, model.toMap());
  }

  Future<int> deleteNote(int id) async {
    return await AppDatabase.deleteNote(id);
  }
}
