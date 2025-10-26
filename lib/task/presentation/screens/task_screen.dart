import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/task/domain/entities/task_entity.dart';
import 'package:notes_tasks/task/presentation/widgets/task_card.dart';
import 'package:notes_tasks/task/presentation/screens/add_task_screen.dart';
import 'package:notes_tasks/task/presentation/screens/update_task_screen.dart';
import 'package:notes_tasks/task/presentation/viewmodels/delete_task_viewmodel.dart';
import 'package:notes_tasks/task/presentation/viewmodels/get_all_tasks_viewmodel.dart';
import 'package:notes_tasks/core/widgets/app_snackbar.dart';
import 'package:notes_tasks/task/presentation/providers/task_providers.dart';

class TaskScreen extends ConsumerWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksState = ref.watch(getAllTasksViewModelProvider);
    final taskNotifier = ref.read(getAllTasksViewModelProvider.notifier);
    final deleteNotifier = ref.read(deleteTaskViewModelProvider.notifier);
    final expandState = ref.watch(CardExpandedProvider);
    final expandNotifier = ref.read(CardExpandedProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      body: tasksState.when(
        data: (tasks) => RefreshIndicator(
          onRefresh: () async => await taskNotifier.refreshTasks(),
          child: tasks.isEmpty
              ? const Center(child: Text('No tasks yet.'))
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    final isExpanded = expandState[task.id] ?? false;

                    return TaskCard(
                      task: task,
                      isExpanded: isExpanded,
                      onTap: () {
                        if (task.id != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  UpdateTaskScreen(taskId: task.id!),
                            ),
                          );
                        } else {
                          AppSnackbar.show(context, 'Task has no ID yet.');
                        }
                      },
                      onDelete: () async {
                        if (task.id != null) {
                          await deleteNotifier.deleteTask(task.id!);
                          await taskNotifier.refreshTasks();
                          AppSnackbar.show(
                            context,
                            'Deleted: "${task.title}" successfully',
                          );
                        }
                      },
                      onExpand: () {
                        expandNotifier.state = {
                          ...expandNotifier.state,
                          task.id!: !isExpanded,
                        };
                      },
                    );
                  },
                ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );
          await taskNotifier.refreshTasks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
