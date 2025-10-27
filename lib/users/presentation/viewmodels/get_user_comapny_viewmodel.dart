import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/users/presentation/providers/user_providers.dart';

final getUserCompanyViewModelProvider =
    AsyncNotifierProvider<GetUserCompanyViewModel, CompanyEntity?>(
      GetUserCompanyViewModel.new,
    );

class GetUserCompanyViewModel extends AsyncNotifier<CompanyEntity?> {
  late final _useCase = ref.read(getUserCompanyUseCaseProvider);

  @override
  FutureOr<CompanyEntity?> build() => null;

  Future<void> getUserCompany(int id) async {
    state = const AsyncLoading();
    try {
      final entity = await _useCase.call(id);
      state = AsyncData(entity);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
