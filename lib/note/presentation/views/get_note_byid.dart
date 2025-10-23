import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/note/presentation/viewmodels/get_note_byid_viewmodel.dart';

class UpdateNoteScreen extends ConsumerStatefulWidget {
  final int noteId;
  const UpdateNoteScreen({super.key, required this.noteId});

  @override
  ConsumerState<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends ConsumerState<UpdateNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(noteByIdViewModelProvider.notifier)
          .getNoteById(widget.noteId); // ✅ اسم الدالة الصحيح
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

          // ✅ عشان ما يتكرر التعيين كل إعادة بناء (Rebuild)
          _titleController.text = _titleController.text.isEmpty
              ? note.title
              : _titleController.text;
          _contentController.text = _contentController.text.isEmpty
              ? note.content
              : _contentController.text;

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
                  controller: _contentController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Update Note'),
                  onPressed: () async {
                    // هون لاحقًا رح نربط updateNote
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Note updated successfully!'),
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
    _contentController.dispose();
    super.dispose();
  }
}
