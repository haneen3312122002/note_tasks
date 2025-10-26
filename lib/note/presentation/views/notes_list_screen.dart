import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/note/domain/entities/note_entity.dart';
import 'package:notes_tasks/note/presentation/views/add_note_screen.dart';
import 'package:notes_tasks/note/presentation/views/update_note_screen.dart';
import 'package:notes_tasks/note/presentation/widgets/note_card.dart';
import 'package:notes_tasks/note/presentation/viewmodels/get_all_notes_viewmodel.dart';
import 'package:notes_tasks/core/widgets/app_snackbar.dart';

class NoteScreen extends ConsumerWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesState = ref.watch(noteViewModelProvider);
    final notesNotifier = ref.read(noteViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: notesState.when(
        data: (notes) => RefreshIndicator(
          onRefresh: () async => await notesNotifier.getAllNotes(),
          child: notes.isEmpty
              ? const Center(child: Text('No notes found.'))
              : ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return NoteCard(
                      note: note,
                      onTap: () {
                        if (note.id != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  UpdateNoteScreen(noteId: note.id!),
                            ),
                          );
                        } else {
                          AppSnackbar.show(context, 'Note has no ID yet.');
                        }
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
            MaterialPageRoute(builder: (_) => const AddNoteScreen()),
          );
          await notesNotifier.getAllNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
