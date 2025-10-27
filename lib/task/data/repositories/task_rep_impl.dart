// lib/task/data/repositories/task_rep_impl.dart
import 'package:notes_tasks/task/data/datasourse/task_datasourse.dart';
import 'package:notes_tasks/task/domain/entities/task_entity.dart';
import 'package:notes_tasks/task/domain/repositories/task_rep.dart';

class TaskRepImpl implements TaskRepo {
  final TaskDataSource ds;

  TaskRepImpl({required this.ds});

  @override
  Future<List<TaskEntity>> getAllTasks() async {
    return await ds.getAllTasks();
  }
}
