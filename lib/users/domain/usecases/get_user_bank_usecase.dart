import 'package:notes_tasks/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/users/domain/repositories/user_repo.dart';

class GetUserBankUseCase {
  final UserRepo repo;
  GetUserBankUseCase(this.repo);

  Future<BankEntity> call(int id) async {
    return await repo.getUserBank(id);
  }
}
