import 'package:flutter/material.dart';
import '../models/task.dart';
import '../constants/styles.dart';
import '../widgets/task_item.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Task> taskList = Task.initialTasks();
  List<Task> filteredTasks = [];
  final TextEditingController taskInputController = TextEditingController();

  @override
  void initState() {
    filteredTasks = taskList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: buildHeader(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                searchInput(),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        'My Tasks',
                        style: AppStyles.headingStyle,
                      ),
                      for (Task t in filteredTasks.reversed)
                        TaskItem(
                          task: t,
                          onTaskChange: toggleTaskStatus,
                          onDeleteTask: deleteTask,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          addTaskBar(),
        ],
      ),
    );
  }

  AppBar buildHeader() {
    return AppBar(
      backgroundColor: AppColors.bgDark,
      elevation: 0,
      title: Text(
        'Task Manager',
        style: TextStyle(color: AppColors.white),
      ),
      actions: [
        Icon(Icons.task_alt, color: AppColors.primaryOrange),
        SizedBox(width: 16),
      ],
    );
  }

  void toggleTaskStatus(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  void deleteTask(String id) {
    setState(() {
      taskList.removeWhere((item) => item.id == id);
    });
  }

  void addTask(String taskText) {
    if (taskText.isNotEmpty) {
      setState(() {
        taskList.add(Task(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            taskText: taskText));
        filteredTasks = taskList;
      });
      taskInputController.clear();
    }
  }

  Widget searchInput() {
    return TextField(
      onChanged: (value) {
        setState(() {
          filteredTasks = value.isEmpty
              ? taskList
              : taskList
                  .where((task) => task.taskText!
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList();
        });
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: AppColors.primaryTeal),
        hintText: 'Search tasks...',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget addTaskBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: taskInputController,
                decoration: InputDecoration(
                  hintText: 'Add a new task',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              onPressed: () => addTask(taskInputController.text),
              backgroundColor: AppColors.primaryTeal,
              child: Icon(Icons.add, color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
