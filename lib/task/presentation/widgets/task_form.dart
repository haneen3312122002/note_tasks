import 'package:flutter/material.dart';
import 'package:notes_tasks/core/widgets/custom_text_field.dart';
import 'package:notes_tasks/task/presentation/widgets/status_dropdown.dart';
import 'package:notes_tasks/core/widgets/primary_button.dart';
import 'package:notes_tasks/core/widgets/app_snackbar.dart';
import 'package:notes_tasks/task/domain/entities/task_entity.dart';

class TaskForm extends StatefulWidget {
  final TaskEntity? initialTask;
  final Future<void> Function(TaskEntity task) onSubmit;

  const TaskForm({super.key, this.initialTask, required this.onSubmit});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _status = 'pending';

  @override
  void initState() {
    super.initState();
    if (widget.initialTask != null) {
      _titleController.text = widget.initialTask!.title;
      _descriptionController.text = widget.initialTask!.description;
      _status = widget.initialTask!.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          controller: _titleController,
          label: 'Title',
          inputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _descriptionController,
          label: 'Description',
          maxLines: 4,
        ),
        const SizedBox(height: 12),
        StatusDropdown(
          value: _status,
          onChanged: (val) => setState(() => _status = val),
        ),
        const SizedBox(height: 20),
        PrimaryButton(
          label: widget.initialTask == null ? 'Save Task' : 'Save Changes',
          icon: Icons.save,
          onPressed: () async {
            if (_titleController.text.isEmpty ||
                _descriptionController.text.isEmpty) {
              AppSnackbar.show(context, 'Please fill all fields');
              return;
            }

            final task = TaskEntity(
              id: widget.initialTask?.id,
              title: _titleController.text.trim(),
              description: _descriptionController.text.trim(),
              date: DateTime.now(),
              status: _status,
            );

            await widget.onSubmit(task);
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
