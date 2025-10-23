import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_rep.dart';

class UpdateTaskUseCase {
  final TaskRep rep;
  UpdateTaskUseCase({required this.rep});
  Future<int> call(TaskEntity task) async {
    return await rep.updateTask(task);
  }
}
