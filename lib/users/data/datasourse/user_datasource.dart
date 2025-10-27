import 'package:notes_tasks/core/user_api_service.dart';
import 'package:notes_tasks/users/data/models/user_model.dart';

class UserDataSource {
  final UserApiService api;
  UserDataSource(this.api);

  Future<List<UserModel>> getBasicUsers() async {
    final data = await api.getBasicUsers();
    return data.map((e) => UserModel.fromMap(e)).toList();
  }

  Future<UserModel> getUserFull(int id) async {
    final data = await api.getUserFull(id);
    return UserModel.fromMap(data);
  }

  Future<BankModel> getUserBank(int id) async {
    final data = await api.getUserBank(id);
    return BankModel.fromMap(data);
  }

  Future<CompanyModel> getUserCompany(int id) async {
    final data = await api.getUserCompany(id);
    return CompanyModel.fromMap(data);
  }

  Future<CryptoModel> getUserCrypto(int id) async {
    final data = await api.getUserCrypto(id);
    return CryptoModel.fromMap(data);
  }

  Future<AddressModel> getUserAddress(int id) async {
    final data = await api.getUserAddress(id);
    return AddressModel.fromMap(data);
  }
}
