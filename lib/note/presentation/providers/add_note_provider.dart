import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/note/data/datasourse/note_datasourse.dart';
import 'package:notes_tasks/note/data/repositories/note_repimpl.dart';
import 'package:notes_tasks/note/domain/repositories/note_rep.dart';
import 'package:notes_tasks/note/domain/usecases/add_note_usecase.dart';
import 'package:notes_tasks/note/domain/usecases/get_all_notes_usecase.dart';

final noteDataSourceProvider = Provider<NoteDataSource>((ref) {
  return NoteDataSource();
});
//...........................
final noteRepositoryProvider = Provider<NoteRep>((ref) {
  final localSource = ref.watch(noteDataSourceProvider);
  return NoteRepImpl(ds: localSource);
});
//............................
final addNotesUseCaseProvider = Provider<AddNoteUseCase>((ref) {
  final rep = ref.watch(noteRepositoryProvider);
  return AddNoteUseCase(rep: rep);
});
//..................
