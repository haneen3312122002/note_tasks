import 'package:notes_tasks/core/database.dart';
import '../models/note_model.dart';
import '../../domain/entities/note_entity.dart';

class NoteDataSource {
  Future<int> insertNote(NoteEntity note) async {
    final model = NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      date: note.date,
    );
    final newId = await AppDatabase.insertNote(model.toMap());
    return newId;
  }

  Future<List<NoteModel>> getAllNotes() async {
    final List<Map<String, dynamic>> maps = await AppDatabase.getAllNotes();
    return maps.map((map) => NoteModel.fromMap(map)).toList();
  }

  Future<NoteModel?> getNoteById(int id) async {
    final map = await AppDatabase.getNoteById(id);
    if (map != null) return NoteModel.fromMap(map);
    return null;
  }

  Future<int> updateNote(NoteEntity note) async {
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
