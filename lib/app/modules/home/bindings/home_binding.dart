import 'package:get/get.dart';
import 'package:project_constructor/app/data/services/storage/respository.dart';

import '../../../data/providers/provider.dart';
import '../controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),),
      ),
    );
  }
}
