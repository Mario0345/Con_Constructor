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
    super.onClose();
  }

  void changeCheapIndex(int value){
    chipIndex.value = value;
  }

  bool addTask(Task task){
    if(tasks.contains(task)){
      return false;

    }
    else{
      tasks.add(task);
      return true;
    }
  }

  // void increment() => count.value++;
}
