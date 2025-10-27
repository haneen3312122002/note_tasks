import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/users/presentation/providers/user_providers.dart';

final getUserAddressViewModelProvider =
    AsyncNotifierProvider<GetUserAddressViewModel, AddressEntity?>(
      GetUserAddressViewModel.new,
    );

class GetUserAddressViewModel extends AsyncNotifier<AddressEntity?> {
  late final _useCase = ref.read(getUserAddressUseCaseProvider);

  @override
  FutureOr<AddressEntity?> build() => null;

  Future<void> getUserAddress(int id) async {
    state = const AsyncLoading();
    try {
      final entity = await _useCase.call(id);
      state = AsyncData(entity);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
