import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/task/domain/usecases/delete_task_usecase.dart';
import 'package:notes_tasks/task/presentation/providers/task_providers.dart';

final deleteTaskViewModelProvider =
    AsyncNotifierProvider<DeleteTaskViewModelNotifier, int>(
      DeleteTaskViewModelNotifier.new,
    );

class DeleteTaskViewModelNotifier extends AsyncNotifier<int> {
  late final DeleteTaskUseCase deleteTaskUseCase;

  @override
  Future<int> build() async {
    deleteTaskUseCase = ref.watch(deleteTaskUseCaseProvider);
    state = const AsyncValue.data(-1);
    return -1;
  }

  Future<int> deleteTask(int id) async {
    state = const AsyncValue.loading();
    try {
      final deletedId = await deleteTaskUseCase.call(id);
      state = AsyncValue.data(deletedId);
      return deletedId;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
