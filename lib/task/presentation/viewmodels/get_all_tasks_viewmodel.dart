import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/task/domain/entities/task_entity.dart';
import 'package:notes_tasks/task/domain/usecases/get_all_tasks_usecase.dart';
import 'package:notes_tasks/task/presentation/providers/task_providers.dart';

final getAllTasksViewModelProvider =
    AsyncNotifierProvider<GetAllTasksViewModel, List<TaskEntity>>(
      GetAllTasksViewModel.new,
    );

class GetAllTasksViewModel extends AsyncNotifier<List<TaskEntity>> {
  late final GetAllTasksUseCase _getAllTasksUseCase;

  @override
  FutureOr<List<TaskEntity>> build() async {
    try {
      _getAllTasksUseCase = ref.watch(getAllTasksUseCaseProvider);
      final tasks = await _getAllTasksUseCase.call();
      return tasks; // ✅ لا تغيّر state داخل build
    } catch (e, st) {
      print('❌ Error in GetAllTasksViewModel.build: $e');
      return [];
    }
  }

  Future<void> refreshTasks() async {
    state = const AsyncLoading();
    try {
      final tasks = await _getAllTasksUseCase.call();
      state = AsyncData(tasks);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
