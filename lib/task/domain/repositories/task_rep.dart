// lib/task/domain/repositories/task_repository.dart
import 'package:notes_tasks/task/domain/entities/task_entity.dart';

abstract class TaskRepo {
  Future<List<TaskEntity>> getAllTasks();
}
