import 'package:notes_tasks/note/data/models/note_model.dart';
import 'package:notes_tasks/note/domain/entities/note_entity.dart';
import 'package:notes_tasks/note/domain/repositories/note_rep.dart';

class GetNoteByIdUseCase {
  final NoteRep rep;

  GetNoteByIdUseCase({required this.rep});

  Future<NoteEntity?> call(int id) async {
    return await rep.getNoteById(id);
  }
}
