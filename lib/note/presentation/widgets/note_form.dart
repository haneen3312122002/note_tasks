import 'package:flutter/material.dart';
import 'package:notes_tasks/core/widgets/custom_text_field.dart';
import 'package:notes_tasks/core/widgets/primary_button.dart';
import 'package:notes_tasks/core/widgets/app_snackbar.dart';
import 'package:notes_tasks/note/domain/entities/note_entity.dart';

class NoteForm extends StatefulWidget {
  final NoteEntity? initialNote;
  final Future<void> Function(NoteEntity note) onSubmit;

  const NoteForm({super.key, this.initialNote, required this.onSubmit});

  @override
  State<NoteForm> createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialNote != null) {
      _titleController.text = widget.initialNote!.title;
      _contentController.text = widget.initialNote!.content;
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
          controller: _contentController,
          label: 'Content',
          maxLines: 5,
        ),
        const SizedBox(height: 20),
        PrimaryButton(
          label: widget.initialNote == null ? 'Save Note' : 'Update Note',
          icon: Icons.save,
          onPressed: () async {
            if (_titleController.text.isEmpty ||
                _contentController.text.isEmpty) {
              AppSnackbar.show(context, 'Please fill all fields');
              return;
            }

            final note = NoteEntity(
              id: widget.initialNote?.id,
              title: _titleController.text.trim(),
              content: _contentController.text.trim(),
              date: DateTime.now(),
            );

            await widget.onSubmit(note);
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
