import 'package:notes_tasks/note/domain/entities/note_entity.dart';
import 'package:notes_tasks/note/domain/repositories/note_rep.dart';

class GetAllNotesUseCase {
  final NoteRep rep;

  GetAllNotesUseCase({required this.rep});

  Future<List<NoteEntity>> call() async {
    return await rep.getAllNotes();
  }
}
