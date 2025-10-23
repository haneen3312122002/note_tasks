import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/task/domain/entities/task_entity.dart';
import 'package:notes_tasks/task/presentation/viewmodels/add_task_viewmodel.dart';

class AddTaskScreen extends ConsumerWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String status = 'pending';
    final notifier = ref.read(addTaskViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: status,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'pending', child: Text('Pending')),
                DropdownMenuItem(value: 'done', child: Text('Done')),
              ],
              onChanged: (val) => status = val!,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                if (titleController.text.isEmpty ||
                    descriptionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                  return;
                }

                await notifier.addTask(
                  TaskEntity(
                    title: titleController.text,
                    description: descriptionController.text,
                    date: DateTime.now(),
                    status: status,
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Task "${titleController.text}" added!'),
                  ),
                );

                Navigator.pop(context);
              },
              icon: const Icon(Icons.save),
              label: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
