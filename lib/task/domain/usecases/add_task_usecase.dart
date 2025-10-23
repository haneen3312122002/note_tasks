import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_rep.dart';

class AddTaskUseCase {
  final TaskRep rep;
  AddTaskUseCase({required this.rep});
  Future<int> call(TaskEntity task) async {
    return await rep.insertTask(task);
  }
}
