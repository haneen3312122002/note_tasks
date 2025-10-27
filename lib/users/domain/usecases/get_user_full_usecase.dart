import 'package:notes_tasks/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/users/domain/repositories/user_repo.dart';

class GetUserFullUseCase {
  final UserRepo repo;
  GetUserFullUseCase(this.repo);

  Future<UserEntity> call(int id) async {
    return await repo.getUserFull(id);
  }
}
