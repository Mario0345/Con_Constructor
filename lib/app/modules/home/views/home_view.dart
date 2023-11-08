import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:project_constructor/app/core/utils/extensions.dart';
import 'package:project_constructor/app/core/values/colors.dart';
import 'package:project_constructor/app/data/models/task.dart';
import 'package:project_constructor/app/modules/home/widgets/add_card.dart';
import 'package:project_constructor/app/modules/home/widgets/task_card.dart';

import '../controllers/home_controller.dart';
import '../widgets/add_dialog.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 60.0.wp,
                left: 3.0.wp,
                top: 3.0.wp,
              ),
              child: SizedBox(
                height: 50,
                child: TextButton(
                 
                  onPressed: () => Get.toNamed('/report'),
                  child: Text(
                    "Общая информация",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 11.4.sp,
                      ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),

              //   child: Text("Hello its List!",
              // style: TextStyle(
              //   fontSize: 16.0.sp,
              //   fontWeight: FontWeight.bold,
              // ),
              // ),
            ),
            Obx(
              () => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  ...controller.tasks
                      .map(
                        (elem) => LongPressDraggable(
                          onDragStarted: () => controller.changeDeleting(true),
                          onDraggableCanceled: (_, __) =>
                              controller.changeDeleting(false),
                          onDragEnd: (_) => controller.changeDeleting(false),
                          data: elem,
                          feedback: Opacity(
                            opacity: 0.8,
                            child: TaskCard(task: elem),
                          ),
                          child: TaskCard(task: elem),
                        ),
                      )
                      .toList(),
                  // TaskCard(
                  //   task: Task(
                  //     title: 'title',
                  //      icon: 0xe59c,
                  //       color: "#FF2B60E6",
                  //       ),
                  //       ),
                  AddCard(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: DragTarget<Task>(builder: (
        _,
        __,
        ___,
      ) {
        return Obx(
          () => FloatingActionButton(
            backgroundColor: controller.deleting.value ? Colors.cyan : blue,
            onPressed: () {
              if (controller.tasks.isNotEmpty) {
                Get.to(() => AddDialog(), transition: Transition.downToUp);
              } else {
                EasyLoading.showInfo("Create type of con/task");
              }
            },
            child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
          ),
        );
      }, onAccept: (Task task) {
        controller.deleteTask(task);
        EasyLoading.showSuccess("Deleted");
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
