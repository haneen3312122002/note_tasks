import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_rep.dart';

class GetTaskByIdUseCase {
  final TaskRep rep;
  GetTaskByIdUseCase({required this.rep});
  Future<TaskEntity?> call(int id) async {
    return await rep.getTaskById(id);
  }
}
