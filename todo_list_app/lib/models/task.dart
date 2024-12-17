class Task {
  String? id;
  String? taskText;
  bool isCompleted;

  Task({required this.id, required this.taskText, this.isCompleted = false});

  static List<Task> initialTasks() {
    return [
      Task(id: '01', taskText: 'Morning Run', isCompleted: true),
      Task(id: '02', taskText: 'Finish Flutter Assignment', isCompleted: false),
      Task(id: '03', taskText: 'Reply to Emails', isCompleted: false),
      Task(id: '04', taskText: 'Meeting with Dev Team', isCompleted: false),
      Task(id: '05', taskText: 'Plan Weekend Trip', isCompleted: true),
    ];
  }
}
