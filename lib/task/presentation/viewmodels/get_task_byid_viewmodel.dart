import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/task/domain/entities/task_entity.dart';
import 'package:notes_tasks/task/domain/usecases/get_task_byid_usecase.dart';
import 'package:notes_tasks/task/presentation/providers/task_providers.dart';

final getTaskByIdViewModelProvider =
    AsyncNotifierProvider<GetTaskByIdViewModel, TaskEntity?>(
      GetTaskByIdViewModel.new,
    );

class GetTaskByIdViewModel extends AsyncNotifier<TaskEntity?> {
  late final GetTaskByIdUseCase _getTaskByIdUseCase;

  @override
  FutureOr<TaskEntity?> build() async {
    _getTaskByIdUseCase = ref.watch(getTaskByIdUseCaseProvider);
    return null;
  }

  Future<void> getTaskById(int id) async {
    state = const AsyncLoading();
    try {
      final task = await _getTaskByIdUseCase.call(id);
      state = AsyncData(task);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
