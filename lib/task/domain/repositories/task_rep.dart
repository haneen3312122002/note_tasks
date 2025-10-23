import '../../domain/entities/task_entity.dart';

abstract class TaskRep {
  Future<int> insertTask(TaskEntity task);
  Future<List<TaskEntity>> getAllTasks();
  Future<TaskEntity?> getTaskById(int id);
  Future<int> updateTask(TaskEntity task);
  Future<int> deleteTask(int id);
}
