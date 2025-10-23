import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/task/presentation/viewmodels/get_task_byid_viewmodel.dart';
import 'package:notes_tasks/task/domain/entities/task_entity.dart';

class UpdateTaskScreen extends ConsumerStatefulWidget {
  final int taskId;
  const UpdateTaskScreen({super.key, required this.taskId});

  @override
  ConsumerState<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends ConsumerState<UpdateTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _status = 'pending';

  @override
  void initState() {
    super.initState();

    // ✅ استدعاء المهمة من قاعدة البيانات عبر Riverpod
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

          // ✅ تعبئة الحقول مرة واحدة فقط
          _titleController.text = _titleController.text.isEmpty
              ? task.title
              : _titleController.text;
          _descriptionController.text = _descriptionController.text.isEmpty
              ? task.description
              : _descriptionController.text;
          _status = task.status;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _status,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'pending', child: Text('Pending')),
                    DropdownMenuItem(value: 'done', child: Text('Done')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _status = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Update Task'),
                  onPressed: () async {
                    // ✅ لاحقاً اربطها مع updateTaskUseCase
                    final updatedTask = TaskEntity(
                      id: widget.taskId,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      date: DateTime.now(),
                      status: _status,
                    );

                    // TODO: بعد ما تعمل updateTaskUseCase، استدعيه هون
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Task updated successfully!'),
                      ),
                    );

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
