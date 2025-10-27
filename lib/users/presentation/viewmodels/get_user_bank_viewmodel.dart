import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/users/presentation/providers/user_providers.dart';

final getUserBankViewModelProvider =
    AsyncNotifierProvider<GetUserBankViewModel, BankEntity?>(
      GetUserBankViewModel.new,
    );

class GetUserBankViewModel extends AsyncNotifier<BankEntity?> {
  late final _useCase = ref.read(getUserBankUseCaseProvider);

  @override
  FutureOr<BankEntity?> build() => null;

  Future<void> getUserBank(int id) async {
    state = const AsyncLoading();
    try {
      final entity = await _useCase.call(id);
      state = AsyncData(entity);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
