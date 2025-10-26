import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/note/presentation/widgets/note_form.dart';
import 'package:notes_tasks/note/presentation/viewmodels/get_note_byid_viewmodel.dart';
import 'package:notes_tasks/core/widgets/app_snackbar.dart';

class UpdateNoteScreen extends ConsumerStatefulWidget {
  final int noteId;
  const UpdateNoteScreen({super.key, required this.noteId});

  @override
  ConsumerState<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends ConsumerState<UpdateNoteScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(noteByIdViewModelProvider.notifier).getNoteById(widget.noteId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final noteState = ref.watch(noteByIdViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Note')),
      body: noteState.when(
        data: (note) {
          if (note == null) {
            return const Center(child: Text('Note not found'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: NoteForm(
              initialNote: note,
              onSubmit: (updatedNote) async {
                AppSnackbar.show(context, 'Note updated successfully!');
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
