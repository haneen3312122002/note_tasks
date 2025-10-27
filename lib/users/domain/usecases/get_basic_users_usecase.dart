import 'package:notes_tasks/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/users/domain/repositories/user_repo.dart';

class GetBasicUsersUseCase {
  final UserRepo repo;
  GetBasicUsersUseCase(this.repo);

  Future<List<UserEntity>> call() async {
    return await repo.getBasicUsers();
  }
}
