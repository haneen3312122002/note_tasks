import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/note/domain/entities/note_entity.dart';
import 'package:notes_tasks/note/domain/usecases/add_note_usecase.dart';
import 'package:notes_tasks/note/presentation/providers/add_note_provider.dart';

final AddNoteViewModelProvider = AsyncNotifierProvider<AddNoteViewmodel, int>(
  AddNoteViewmodel.new,
);

class AddNoteViewmodel extends AsyncNotifier<int> {
  late final AddNoteUseCase addNoteUseCase;
  @override
  Future<int> build() async {
    addNoteUseCase = ref.watch(addNotesUseCaseProvider);
    return -1;
  }

  Future<int> addNote(NoteEntity note) async {
    state = AsyncValue.loading();
    try {
      final res = await addNoteUseCase.call(note);
      state = AsyncValue.data(res);
      return res;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return 0;
    }
  }
}
