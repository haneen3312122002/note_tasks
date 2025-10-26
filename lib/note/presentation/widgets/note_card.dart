import 'package:flutter/material.dart';
import 'package:notes_tasks/core/widgets/date_formatter.dart';
import 'package:notes_tasks/note/domain/entities/note_entity.dart';

class NoteCard extends StatelessWidget {
  final NoteEntity note;
  final VoidCallback onTap;

  const NoteCard({super.key, required this.note, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: ListTile(
        title: Text(
          note.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            note.content,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: Text(
          DateFormatter.format(note.date),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        onTap: onTap,
      ),
    );
  }
}
