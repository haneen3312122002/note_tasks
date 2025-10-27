import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/users/presentation/viewmodels/get_all_basic_users_viewmodel.dart';
import 'package:notes_tasks/users/presentation/widgets/custom_user_list.dart';
import 'package:notes_tasks/task/presentation/widgets/custom_error_view.dart';

class UserScreen extends ConsumerWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersState = ref.watch(getAllBasicUsersViewModelProvider);
    final viewModel = ref.read(getAllBasicUsersViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (role) {
              if (role == 'all') {
                viewModel.clearFilter();
              } else {
                viewModel.filterByRole(role);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'all', child: Text('All')),
              PopupMenuItem(value: 'admin', child: Text('Admins')),
              PopupMenuItem(value: 'moderator', child: Text('Moderators')),
              PopupMenuItem(value: 'user', child: Text('Users')),
            ],
          ),
        ],
      ),
      body: usersState.when(
        data: (List<UserEntity> users) => CustomUserList(
          users: users,
          onRefresh: viewModel.refreshUsers,
          onTapItem: (user) {
            debugPrint('Tapped on ${user.firstName}');
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => CustomErrorView(
          error: error,
          onRetry: viewModel.refreshUsers,
          message: 'Failed to load users',
        ),
      ),
    );
  }
}
