import 'package:notes_tasks/task/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    required super.id,
    required super.todo,
    required super.completed,
    required super.userId,
  });

  /// json ---> model
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? 0,
      todo: map['todo'] ?? '',
      completed: map['completed'] ?? false,
      userId: map['userId'] ?? 0,
    );
  }

  /// model ---> json
  Map<String, dynamic> toMap() {
    return {'id': id, 'todo': todo, 'completed': completed, 'userId': userId};
  }

  TaskModel copyWith({int? id, String? todo, bool? completed, int? userId}) {
    return TaskModel(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, todo: $todo, completed: $completed, userId: $userId)';
  }
}
