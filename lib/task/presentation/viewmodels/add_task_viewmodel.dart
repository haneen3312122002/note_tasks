import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/task/domain/entities/task_entity.dart';
import 'package:notes_tasks/task/domain/usecases/add_task_usecase.dart';
import 'package:notes_tasks/task/presentation/providers/task_providers.dart';

final addTaskViewModelProvider = AsyncNotifierProvider<AddTaskViewModel, int>(
  AddTaskViewModel.new,
);

class AddTaskViewModel extends AsyncNotifier<int> {
  late final AddTaskUseCase _addTaskUseCase;

  @override
  Future<int> build() async {
    _addTaskUseCase = ref.watch(addTaskUseCaseProvider);
    return -1;
  }

  Future<int> addTask(TaskEntity task) async {
    state = const AsyncLoading();
    try {
      final id = await _addTaskUseCase.call(task);
      state = AsyncData(id);
      return id;
    } catch (e, st) {
      state = AsyncError(e, st);
      return 0;
    }
  }
}
