import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/task/data/datasourse/task_datasource.dart';
import 'package:notes_tasks/task/data/repositories/task_rep_impl.dart';
import 'package:notes_tasks/task/domain/repositories/task_rep.dart';
import 'package:notes_tasks/task/domain/usecases/add_task_usecase.dart';
import 'package:notes_tasks/task/domain/usecases/delete_task_usecase.dart';
import 'package:notes_tasks/task/domain/usecases/get_all_tasks_usecase.dart';
import 'package:notes_tasks/task/domain/usecases/get_task_byid_usecase.dart';

final taskDataSourceProvider = Provider<TaskDataSource>((ref) {
  return TaskDataSource();
});

final taskRepositoryProvider = Provider<TaskRep>((ref) {
  final ds = ref.watch(taskDataSourceProvider);
  return TaskRepImpl(ds: ds);
});

final addTaskUseCaseProvider = Provider<AddTaskUseCase>((ref) {
  final rep = ref.watch(taskRepositoryProvider);
  return AddTaskUseCase(rep: rep);
});

final getAllTasksUseCaseProvider = Provider<GetAllTasksUseCase>((ref) {
  final rep = ref.watch(taskRepositoryProvider);
  return GetAllTasksUseCase(rep: rep);
});

final getTaskByIdUseCaseProvider = Provider<GetTaskByIdUseCase>((ref) {
  final rep = ref.watch(taskRepositoryProvider);
  return GetTaskByIdUseCase(rep: rep);
});
final deleteTaskUseCaseProvider = Provider<DeleteTaskUseCase>((ref) {
  final rep = ref.watch(taskRepositoryProvider);
  return DeleteTaskUseCase(rep: rep);
});
