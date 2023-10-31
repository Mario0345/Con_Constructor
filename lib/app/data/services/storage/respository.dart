import '../../models/task.dart';
import '../../providers/provider.dart';


class TaskRepository{
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});
  

  List<Task> readTasks() => taskProvider.readTasks();
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}