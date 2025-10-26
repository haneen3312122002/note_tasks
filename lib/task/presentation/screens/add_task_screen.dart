import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/task/presentation/widgets/task_form.dart';
import 'package:notes_tasks/task/presentation/viewmodels/add_task_viewmodel.dart';
import 'package:notes_tasks/core/widgets/app_snackbar.dart';

class AddTaskScreen extends ConsumerWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(addTaskViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TaskForm(
          onSubmit: (task) async {
            await notifier.addTask(task);
            AppSnackbar.show(context, 'Task "${task.title}" added!');
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
