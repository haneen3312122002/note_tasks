import 'package:notes_tasks/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/users/domain/repositories/user_repo.dart';

class GetUserCompanyUseCase {
  final UserRepo repo;
  GetUserCompanyUseCase(this.repo);

  Future<CompanyEntity> call(int id) async {
    return await repo.getUserCompany(id);
  }
}
