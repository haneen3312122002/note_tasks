import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/users/domain/usecases/get_basic_users_usecase.dart';
import 'package:notes_tasks/users/presentation/providers/user_providers.dart';

final getAllBasicUsersViewModelProvider =
    AsyncNotifierProvider<GetAllBasicUsersViewModel, List<UserEntity>>(
      GetAllBasicUsersViewModel.new,
    );

class GetAllBasicUsersViewModel extends AsyncNotifier<List<UserEntity>> {
  late final GetBasicUsersUseCase _getBasicUsersUseCase = ref.read(
    getBasicUsersUseCaseProvider,
  );

  List<UserEntity> _allUsers = [];

  @override
  FutureOr<List<UserEntity>> build() async {
    return _loadUsers();
  }

  Future<List<UserEntity>> _loadUsers() async {
    try {
      final users = await _getBasicUsersUseCase.call();
      _allUsers = users;
      return users;
    } catch (e, st) {
      state = AsyncError(e, st);
      return [];
    }
  }

  Future<void> refreshUsers() async {
    state = const AsyncLoading();
    try {
      final users = await _getBasicUsersUseCase.call();
      _allUsers = users;
      state = AsyncData(users);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void filterByRole(String role) {
    if (_allUsers.isEmpty) return;
    final filtered = _allUsers.where((u) => u.role == role).toList();
    state = AsyncData(filtered);
  }

  void clearFilter() {
    if (_allUsers.isNotEmpty) {
      state = AsyncData(_allUsers);
    }
  }
}
