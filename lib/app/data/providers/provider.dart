import 'dart:convert';

import 'package:get/get.dart';
import 'package:project_constructor/app/data/services/storage/services.dart';

import '../../core/utils/keys.dart';
import '../models/task.dart';

class TaskProvider {
  StorageService _storage = Get.find<StorageService>();

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
    .forEach((elem) => tasks.add(Task.fromJson(elem)));
    return tasks;
  }

  void writeTasks(List<Task> tasks){
    _storage.write(taskKey, jsonEncode(tasks));
  }

}