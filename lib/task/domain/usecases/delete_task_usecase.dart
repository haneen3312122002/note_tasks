import '../../domain/repositories/task_rep.dart';

class DeleteTaskUseCase {
  final TaskRep rep;
  DeleteTaskUseCase({required this.rep});
  Future<int> call(int id) async {
    return await rep.deleteTask(id);
  }
}
