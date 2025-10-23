import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/note/presentation/viewmodels/get_all_notes_viewmodel.dart';
import 'package:notes_tasks/note/domain/entities/note_entity.dart';
import 'package:notes_tasks/note/presentation/views/add_note_screen.dart';
import 'package:notes_tasks/note/presentation/views/get_note_byid.dart';

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
          onRefresh: () async {
            await ref
                .watch(noteViewModelProvider.notifier)
                .getAllNotes(); // تحديث عند السحب
          },
          child: notes.isEmpty
              ? const Center(child: Text('No notes found.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final NoteEntity note = notes[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text(
                          note.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          // للتأكد إن الـ id موجود
                          if (note.id != null) {
                            print('Tapped note with id: ${note.id}');

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => UpdateNoteScreen(
                                  noteId: note.id!,
                                ), // ✅ الانتقال الحقيقي
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Note has no ID yet.'),
                              ),
                            );
                          }
                        },

                        subtitle: Text(note.content),
                        trailing: Text(
                          note.date.toString(), // حسب الحقل الموجود عندك
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    );
                  },
                ),
        ),
        error: (e, st) => Center(child: Text('$e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // نفتح صفحة الإضافة
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNoteScreen()),
          );

          await notesNotifier.getAllNotes();
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
