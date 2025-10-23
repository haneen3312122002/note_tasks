import 'package:notes_tasks/note/domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  final int? id;

  NoteModel({
    this.id,
    required String title,
    required String content,
    required DateTime date,
  }) : super(id: id, title: title, content: content, date: date);

  // 🔹 لتحويل من Model إلى Map (لـ SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id, // ملاحظي: نحفظه فقط عند التحديث
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
    };
  }

  // 🔹 لتحويل من Map إلى Model (من DB إلى App)
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as int?,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      date: DateTime.parse(map['date']),
    );
  }
}
