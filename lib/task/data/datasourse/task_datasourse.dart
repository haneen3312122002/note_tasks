import 'package:notes_tasks/core/task_api_service.dart';
import 'package:notes_tasks/task/data/models/task_model.dart';
import 'package:notes_tasks/task/domain/entities/task_entity.dart';

class TaskDataSource {
  final TaskApiService apiService;

  TaskDataSource(this.apiService);

  Future<List<TaskEntity>> getAllTasks() async {
    final data = await apiService.get('todos');
    final List todos = data['todos'];
    return todos.map((e) => TaskModel.fromMap(e)).toList();
  }
}
