

import 'package:notes_tasks/note/domain/entities/note_entity.dart';

abstract class NoteRep {
  Future<int> insertNote(NoteEntity note);
  Future<List<NoteEntity>> getAllNotes();
  Future<NoteEntity?> getNoteById(int id);
  Future<int> updateNote(NoteEntity note);
  Future<int> deleteNote(int id);
}

