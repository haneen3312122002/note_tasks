import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/note/domain/entities/note_entity.dart';
import 'package:notes_tasks/note/domain/usecases/get_note_byid_usecase.dart';
import 'package:notes_tasks/note/presentation/providers/get_note_byid_provider.dart';

final noteByIdViewModelProvider =
    AsyncNotifierProvider<GetNoteByIdViewModel, NoteEntity?>(
      GetNoteByIdViewModel.new,
    );

class GetNoteByIdViewModel extends AsyncNotifier<NoteEntity?> {
  late final GetNoteByIdUseCase _getNoteByIdUseCase;

  @override
  FutureOr<NoteEntity?> build() async {
    _getNoteByIdUseCase = ref.watch(getNoteByIdUseCaseProvider);
    return null;
  }

  Future<void> getNoteById(int id) async {
    state = const AsyncLoading();

    try {
      final note = await _getNoteByIdUseCase.call(id);
      state = AsyncData(note);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> refresh(int id) async {
    state = const AsyncLoading();
    try {
      final note = await _getNoteByIdUseCase.call(id);
      state = AsyncData(note);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
