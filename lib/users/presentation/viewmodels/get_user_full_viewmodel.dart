import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/users/domain/usecases/get_user_full_usecase.dart';
import 'package:notes_tasks/users/presentation/providers/user_providers.dart';

final getUserFullViewModelProvider =
    AsyncNotifierProvider<GetUserFullViewModel, UserEntity?>(
      GetUserFullViewModel.new,
    );

class GetUserFullViewModel extends AsyncNotifier<UserEntity?> {
  late final GetUserFullUseCase _getUserFullUseCase = ref.read(
    getUserFullUseCaseProvider,
  );

  @override
  FutureOr<UserEntity?> build() async {
    return null;
  }

  Future<void> getUserById(int id) async {
    state = const AsyncLoading();
    try {
      final user = await _getUserFullUseCase.call(id);
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> refreshUser(int id) async {
    await getUserById(id);
  }
}
