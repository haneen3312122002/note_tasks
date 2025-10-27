import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/core/task_api_service.dart';
import 'package:notes_tasks/task/data/datasourse/task_datasourse.dart';
import 'package:notes_tasks/task/data/repositories/task_rep_impl.dart';
import 'package:notes_tasks/task/domain/repositories/task_rep.dart';
import 'package:notes_tasks/task/domain/usecases/get_all_tasks_usecase.dart';

final apiServiceProvider = Provider<TaskApiService>((ref) {
  return TaskApiService();
});

final taskDataSourceProvider = Provider<TaskDataSource>((ref) {
  final api = ref.read(apiServiceProvider);
  return TaskDataSource(api);
});

final taskRepoProvider = Provider<TaskRepo>((ref) {
  final ds = ref.read(taskDataSourceProvider);
  return TaskRepImpl(ds: ds);
});

final getAllTasksUseCaseProvider = Provider<GetAllTasksUseCase>((ref) {
  final repo = ref.read(taskRepoProvider);
  return GetAllTasksUseCase(rep: repo);
});
