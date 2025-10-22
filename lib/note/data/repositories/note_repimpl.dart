import 'package:notes_tasks/note/data/datasourse/note_datasourse.dart';
import 'package:notes_tasks/note/domain/repositories/note_rep.dart';

import '../../domain/entities/note_entity.dart';

class NoteRepositoryImpl implements NoteRep {
  final NoteDataSource ds;

  NoteRepositoryImpl({required this.ds});

  @override
  Future<int> insertNote(NoteEntity note) async {
    return await ds.insertNote(note);
  }

  @override
  Future<List<NoteEntity>> getAllNotes() async {
    final models = await ds.getAllNotes();
    return models
        .map(
          (m) => NoteEntity(
            id: m.id,
            title: m.title,
            content: m.content,
            date: m.date,
          ),
        )
        .toList();
  }

  @override
  Future<NoteEntity?> getNoteById(int id) async {
    final map = await AppDatabase.getNoteById(id);

    if (map != null) {
      // تحويل من Map → Model → Entity
      final model = NoteModel.fromMap(map);
      return NoteEntity(
        id: model.id,
        title: model.title,
        content: model.content,
        date: model.date,
      );
    } else {
      return null; // لم يتم العثور على الصف
    }
  }

  @override
  Future<int> updateNote(NoteEntity note) async {
    return await ds.updateNote(note);
  }

  @override
  Future<int> deleteNote(int id) async {
    return await ds.deleteNote(id);
  }
}
