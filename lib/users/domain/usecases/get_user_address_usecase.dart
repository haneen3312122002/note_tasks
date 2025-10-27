import 'package:notes_tasks/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/users/domain/repositories/user_repo.dart';

class GetUserAddressUseCase {
  final UserRepo repo;
  GetUserAddressUseCase(this.repo);

  Future<AddressEntity> call(int id) async {
    return await repo.getUserAddress(id);
  }
}
