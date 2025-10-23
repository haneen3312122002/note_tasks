
import 'package:notes_tasks/task/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  final int? id;
  final String title;
  final String description;
  final String date;
  final String status;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  }) : super(id: 0, title: '', description: '', date: '', status: '');

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'status': status,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      status: map['status'] ?? '',
    );
  }

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    String? date,
    String? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, description: $description, date: $date, status: $status)';
  }
}
