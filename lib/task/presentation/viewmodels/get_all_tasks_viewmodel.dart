// lib/task/presentation/viewmodels/get_all_tasks_viewmodel.dart
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
  late final GetAllTasksUseCase _getAllTasksUseCase = ref.read(
    getAllTasksUseCaseProvider,
  );

  @override
  FutureOr<List<TaskEntity>> build() async {
    return _loadTasks();
  }

  Future<List<TaskEntity>> _loadTasks() async {
    try {
      final tasks = await _getAllTasksUseCase.call();
      return tasks;
    } catch (e, st) {
      print(' Error in GetAllTasksViewModel.build: $e');
      // يرجع AsyncError ليتعامل معه واجهة المستخدم
      state = AsyncError(e, st);
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
