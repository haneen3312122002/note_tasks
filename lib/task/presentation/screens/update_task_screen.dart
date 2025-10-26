import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/task/presentation/viewmodels/get_task_byid_viewmodel.dart';
import 'package:notes_tasks/task/presentation/widgets/task_form.dart';
import 'package:notes_tasks/task/domain/entities/task_entity.dart';
import 'package:notes_tasks/core/widgets/app_snackbar.dart';

class UpdateTaskScreen extends ConsumerStatefulWidget {
  final int taskId;
  const UpdateTaskScreen({super.key, required this.taskId});

  @override
  ConsumerState<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends ConsumerState<UpdateTaskScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(getTaskByIdViewModelProvider.notifier)
          .getTaskById(widget.taskId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskState = ref.watch(getTaskByIdViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: taskState.when(
        data: (task) {
          if (task == null) {
            return const Center(child: Text('Task not found'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: TaskForm(
              initialTask: task,
              onSubmit: (updatedTask) async {
                AppSnackbar.show(context, 'Task updated successfully!');
                Navigator.pop(context);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
