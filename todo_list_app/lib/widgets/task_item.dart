import 'package:flutter/material.dart';
import '../models/task.dart';
import '../constants/styles.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(Task) onTaskChange;
  final Function(String) onDeleteTask;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onTaskChange,
    required this.onDeleteTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: task.isCompleted ? AppColors.completedTask : AppColors.cardColor,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: AppColors.primaryTeal,
        ),
        title: Text(
          task.taskText!,
          style: TextStyle(
            fontSize: 18,
            color: task.isCompleted ? Colors.grey : Colors.black87,
            decoration:
                task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () => onDeleteTask(task.id!),
        ),
        onTap: () => onTaskChange(task),
      ),
    );
  }
}
