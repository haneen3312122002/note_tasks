import 'dart:async';
import 'package:notes_tasks/note/presentation/providers/add_note_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/note/domain/entities/note_entity.dart';
import 'package:notes_tasks/note/domain/usecases/get_all_notes_usecase.dart';

final noteViewModelProvider =
    AsyncNotifierProvider<GetAllNotesViewModelNotifier, List<NoteEntity>>(
      GetAllNotesViewModelNotifier.new,
    );

class GetAllNotesViewModelNotifier extends AsyncNotifier<List<NoteEntity>> {
  late final GetAllNotesUseCase getAllNotesUseCase;
  @override
  FutureOr<List<NoteEntity>> build() async {
    getAllNotesUseCase = ref.watch(getAllNotesUseCaseProvider);
    final notes = await getAllNotes();
    return notes;
  }

  Future<List<NoteEntity>> getAllNotes() async {
    state = AsyncValue.loading();
    try {
      final notes = await getAllNotesUseCase.call();
      state = AsyncValue.data(notes);
      return notes;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return [];
    }
  }
}
