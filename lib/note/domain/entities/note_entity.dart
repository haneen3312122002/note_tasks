class NoteEntity {
  final int? id;
  final String title;
  final String content;
  final DateTime date;

  NoteEntity({
    this.id,
    required this.title,
    required this.content,
    required this.date,
  });
}
