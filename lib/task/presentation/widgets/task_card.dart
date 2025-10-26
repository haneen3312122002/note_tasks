import 'package:flutter/material.dart';
import 'package:notes_tasks/core/widgets/date_formatter.dart';
import 'package:notes_tasks/task/domain/entities/task_entity.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;
  final bool isExpanded;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onExpand;

  const TaskCard({
    super.key,
    required this.task,
    required this.isExpanded,
    required this.onTap,
    required this.onDelete,
    required this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    final isDone = task.status == 'done';
    final cardColor = isDone ? Colors.green[100] : Colors.orange[100];

    return InkWell(
      onTap: onTap,
      child: Card(
        color: cardColor,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              if (task.description.isNotEmpty) ...[
                Text(
                  task.description,
                  maxLines: isExpanded ? null : 2,
                  overflow: isExpanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: Colors.grey[700],
                    ),
                    onPressed: onExpand,
                  ),
                ),
              ],
              Text(
                ' ${DateFormatter.format(task.date)}',
                style: TextStyle(color: Colors.grey[700], fontSize: 12),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task.status.toUpperCase(),
                    style: TextStyle(
                      color: isDone ? Colors.green[800] : Colors.orange[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
