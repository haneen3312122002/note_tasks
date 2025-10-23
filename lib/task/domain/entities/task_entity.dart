class TaskEntity {
  final int? id;
  final String title;
  final String description;
  final String date;
  final String status;

  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });
}
