import 'package:notes_tasks/note/data/datasourse/note_datasourse.dart';
import 'package:notes_tasks/note/domain/entities/note_entity.dart';
import 'package:notes_tasks/note/domain/repositories/note_rep.dart';

class NoteRepImpl implements NoteRep {
  final NoteDataSource ds;

  NoteRepImpl({required this.ds});

  @override
  Future<int> insertNote(NoteEntity note) async {
    return await ds.insertNote(note);
  }

  @override
  @override
  Future<List<NoteEntity>> getAllNotes() async {
    final models = await ds.getAllNotes();

    for (var m in models) {
      print('Fetched note => id: ${m.id}, title: ${m.title}');
    }

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
    final model = await ds.getNoteById(id);
    if (model == null) return null;
    return NoteEntity(
      id: model.id,
      title: model.title,
      content: model.content,
      date: model.date,
    );
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
