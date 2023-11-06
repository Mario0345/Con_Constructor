import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_constructor/app/data/services/storage/respository.dart';

import '../../../data/models/task.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});
  final formKey = GlobalKey<FormState>();
  final editCtrl = TextEditingController();
  final tasks = <Task>[].obs;
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final task = Rx<Task?>(null);
  final creatingTodos = <dynamic>[].obs;
  final createdTodos = <dynamic>[].obs;
  // final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    editCtrl.dispose();
    super.onClose();
  }

  void changeCheapIndex(int value) {
    chipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    } else {
      tasks.add(task);
      return true;
    }
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containeTodo(todos, title)) {
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }

  bool containeTodo(List todos, String title) {
    return todos.any((elem) => elem['title'] == title);
  }

  void changeTodos(List<dynamic> select){
    creatingTodos.clear();
    createdTodos.clear();
    for (var i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if(status == true){
        createdTodos.add(todo);
      }
      else{
        creatingTodos.add(todo);
      }
    }
    
  }

  bool addTodo(String title){
    var todo = {'title': title, 'done': false};
    if(creatingTodos.any((elem) => mapEquals<String, dynamic>(todo, elem))){
      return false;
    }
    var todo2 = {'title': title, 'done': true};
    if(createdTodos.any((elem) => mapEquals<String,dynamic>(todo2, elem))){
      return false;
    }
    creatingTodos.add(todo);
    return true; 
  }

  void updateTodos(){
    var newTodos =<Map<String,dynamic>>[];
    newTodos.addAll([
      ...creatingTodos,
      ...createdTodos,]
    );
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIdx = tasks.indexOf(task.value);
    tasks[oldIdx] = newTask;
    tasks.refresh();
  }
  
  void createdTodo(String title){
    var creatingTodo = {'title': title, 'done': false};
    int index = creatingTodos.indexWhere((elem) => mapEquals<String, dynamic>(creatingTodo, elem));
    creatingTodos.removeAt(index);
    var createdTodo = {'title': title, 'done': true};
    createdTodos.add(createdTodo);
    creatingTodos.refresh();
    createdTodos.refresh();
  }
  
}
