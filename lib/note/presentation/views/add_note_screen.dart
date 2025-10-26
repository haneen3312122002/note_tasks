import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/note/presentation/widgets/note_form.dart';
import 'package:notes_tasks/note/presentation/viewmodels/add_note_viewmodel.dart';
import 'package:notes_tasks/core/widgets/app_snackbar.dart';
import 'package:notes_tasks/note/domain/entities/note_entity.dart';

class AddNoteScreen extends ConsumerWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(AddNoteViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: NoteForm(
          onSubmit: (note) async {
            await notifier.addNote(note);
            AppSnackbar.show(context, 'Note "${note.title}" added!');
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
