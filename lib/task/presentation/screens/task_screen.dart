import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/task/presentation/screens/add_task_screen.dart';
import 'package:notes_tasks/task/presentation/screens/get_task_byid.dart';
import 'package:notes_tasks/task/presentation/viewmodels/get_all_tasks_viewmodel.dart';
import 'package:notes_tasks/task/domain/entities/task_entity.dart';
import 'package:intl/intl.dart';

class TaskScreen extends ConsumerWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksState = ref.watch(getAllTasksViewModelProvider);
    final notifier = ref.read(getAllTasksViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      body: tasksState.when(
        data: (tasks) => RefreshIndicator(
          onRefresh: () async => await notifier.refreshTasks(),
          child: tasks.isEmpty
              ? const Center(child: Text('No tasks yet.'))
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final TaskEntity task = tasks[index];
                    final isDone = task.status == 'done';
                    final formattedDate = DateFormat(
                      'yyyy-MM-dd – HH:mm',
                    ).format(task.date);
                    final cardColor = isDone
                        ? Colors.green[100]
                        : Colors.orange[100];

                    return Card(
                      color: cardColor,
                      margin: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 12,
                      ),
                      child: ListTile(
                        title: Text(
                          task.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (task.description.isNotEmpty)
                              Text(task.description),
                            const SizedBox(height: 4),
                            Text(
                              '📅 $formattedDate',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        trailing: Text(
                          task.status.toUpperCase(),
                          style: TextStyle(
                            color: isDone
                                ? Colors.green[800]
                                : Colors.orange[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          if (task.id != null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    UpdateTaskScreen(taskId: task.id!),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Task has no ID yet.'),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
        ),
        error: (e, _) => Center(child: Text('Error: $e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );
          await notifier.refreshTasks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
