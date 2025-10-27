import 'package:notes_tasks/users/data/datasourse/user_datasource.dart';
import 'package:notes_tasks/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/users/domain/repositories/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final UserDataSource ds;
  UserRepoImpl(this.ds);

  @override
  Future<List<UserEntity>> getBasicUsers() async {
    final users = await ds.getBasicUsers();
    return users.map((e) => e.toEntity()).toList();
  }

  @override
  Future<UserEntity> getUserFull(int id) async {
    final user = await ds.getUserFull(id);
    return user.toEntity();
  }

  @override
  Future<BankEntity> getUserBank(int id) async {
    final model = await ds.getUserBank(id);
    return model.toEntity();
  }

  @override
  Future<CompanyEntity> getUserCompany(int id) async {
    final model = await ds.getUserCompany(id);
    return model.toEntity();
  }

  @override
  Future<CryptoEntity> getUserCrypto(int id) async {
    final model = await ds.getUserCrypto(id);
    return model.toEntity();
  }

  @override
  Future<AddressEntity> getUserAddress(int id) async {
    final model = await ds.getUserAddress(id);
    return model.toEntity();
  }
}
