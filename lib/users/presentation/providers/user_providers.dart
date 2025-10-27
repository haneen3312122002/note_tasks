import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/core/user_api_service.dart';
import 'package:notes_tasks/users/data/datasourse/user_datasource.dart';
import 'package:notes_tasks/users/data/repositories/user_repo_impl.dart';
import 'package:notes_tasks/users/domain/repositories/user_repo.dart';
import 'package:notes_tasks/users/domain/usecases/get_basic_users_usecase.dart';
import 'package:notes_tasks/users/domain/usecases/get_user_address_usecase.dart';
import 'package:notes_tasks/users/domain/usecases/get_user_bank_usecase.dart';
import 'package:notes_tasks/users/domain/usecases/get_user_company_usecase.dart';
import 'package:notes_tasks/users/domain/usecases/get_user_full_usecase.dart';

final userApiServiceProvider = Provider((ref) => UserApiService());
final userDataSourceProvider = Provider(
  (ref) => UserDataSource(ref.read(userApiServiceProvider)),
);
final userRepoProvider = Provider<UserRepo>(
  (ref) => UserRepoImpl(ref.read(userDataSourceProvider)),
);

final getBasicUsersUseCaseProvider = Provider(
  (ref) => GetBasicUsersUseCase(ref.read(userRepoProvider)),
);
final getUserFullUseCaseProvider = Provider(
  (ref) => GetUserFullUseCase(ref.read(userRepoProvider)),
);
final getUserBankUseCaseProvider = Provider(
  (ref) => GetUserBankUseCase(ref.read(userRepoProvider)),
);
final getUserCompanyUseCaseProvider = Provider(
  (ref) => GetUserCompanyUseCase(ref.read(userRepoProvider)),
);

final getUserAddressUseCaseProvider = Provider(
  (ref) => GetUserAddressUseCase(ref.read(userRepoProvider)),
);
