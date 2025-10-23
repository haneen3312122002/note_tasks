import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_rep.dart';

class GetAllTasksUseCase {
  final TaskRep rep;
  GetAllTasksUseCase({required this.rep});
  Future<List<TaskEntity>> call() async {
    return await rep.getAllTasks();
  }
}
