import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:notes_tasks/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/users/presentation/viewmodels/get_user_full_viewmodel.dart';

final expandedCardProvider = StateProvider<Map<int, bool>>((ref) => {});

class CustomUserItem extends ConsumerWidget {
  final UserEntity user;
  final VoidCallback? onTap;

  const CustomUserItem({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedCardsState = ref.watch(expandedCardProvider);
    final expandedCardsNotifier = ref.read(expandedCardProvider.notifier);
    final isExpanded = expandedCardsState[user.id] ?? false;

    final userFullState = ref.watch(getUserFullViewModelProvider);
    final userFullNotifier = ref.read(getUserFullViewModelProvider.notifier);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.image),
                radius: 24,
              ),
              title: Text(
                '${user.firstName} ${user.lastName}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                user.role,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
              ),
              trailing: IconButton(
                onPressed: () async {
                  if (!isExpanded) {
                    await userFullNotifier.getUserById(user.id);
                  }

                  expandedCardsNotifier.state = {
                    ...expandedCardsNotifier.state,
                    user.id: !isExpanded,
                  };
                },
                icon: Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  size: 28,
                  color: Colors.grey.shade700,
                ),
              ),
            ),

            if (isExpanded) ...[
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Builder(
                  builder: (context) {
                    if (userFullState.isLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    }

                    if (userFullState.hasError) {
                      return Text(
                        'Error: ${userFullState.error}',
                        style: const TextStyle(color: Colors.red),
                      );
                    }

                    final fullUser = userFullState.value;
                    if (fullUser == null) {
                      return const Text(
                        'No details available',
                        style: TextStyle(color: Colors.grey),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email: ${fullUser.email}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Phone: ${fullUser.phone}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
