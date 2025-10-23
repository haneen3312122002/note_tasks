import 'package:notes_tasks/note/domain/entities/note_entity.dart';
import 'package:notes_tasks/note/domain/repositories/note_rep.dart';

class UpdateNoteUseCase {
  final NoteRep rep;

  UpdateNoteUseCase({required this.rep});

  Future<int> call(NoteEntity note) async {
    return await rep.updateNote(note);
  }
}
