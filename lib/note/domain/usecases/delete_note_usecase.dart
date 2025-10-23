import 'package:notes_tasks/note/domain/repositories/note_rep.dart';

class DeleteNoteUseCase {
  final NoteRep rep;

  DeleteNoteUseCase({required this.rep});

  Future<int> call(int id) async {
    return await rep.deleteNote(id);
  }
}
