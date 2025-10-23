import 'package:notes_tasks/core/database.dart';

import '../../domain/entities/task_entity.dart';
import '../models/task_model.dart';

class TaskDataSource {
  Future<int> insertTask(TaskEntity task) async {
    final model = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      date: task.date,
      status: task.status,
    );
    return await AppDatabase.insertTask(model.toMap());
  }

  Future<List<TaskModel>> getAllTasks() async {
    final List<Map<String, dynamic>> maps = await AppDatabase.getAllTasks();
    return maps.map((map) => TaskModel.fromMap(map)).toList();
  }

  Future<TaskModel?> getTaskById(int id) async {
    final map = await AppDatabase.getTaskById(id);
    if (map != null) return TaskModel.fromMap(map);
    return null;
  }

  Future<int> updateTask(TaskEntity task) async {
    final model = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      date: task.date,
      status: task.status,
    );
    return await AppDatabase.updateTask(task.id!, model.toMap());
  }

  Future<int> deleteTask(int id) async {
    final taskId = await AppDatabase.deleteTask(id);
    return taskId;
  }
}
