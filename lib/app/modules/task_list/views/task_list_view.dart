import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:project_constructor/app/core/utils/extensions.dart';
import 'package:project_constructor/app/modules/home/controllers/home_controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../controllers/task_list_controller.dart';
import '../widgets/created_list.dart';
import '../widgets/creating_list.dart';

class TaskListView extends GetView<TaskListController> {
  final homeCtrl = Get.find<HomeController>();
  TaskListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);
    return Scaffold(
      body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            const Text(
              'TaskListView is working',
              style: TextStyle(fontSize: 18),
            ),
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homeCtrl.updateTodos();
                      homeCtrl.changeTask(null);
                      homeCtrl.editCtrl.clear();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: Row(
                children: [
                  Icon(
                    IconData(
                      task.icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: color,
                  ),
                  SizedBox(
                    width: 3.0.wp,
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              var totalTodos =
                  homeCtrl.creatingTodos.length + homeCtrl.createdTodos.length;
              return Padding(
                padding: EdgeInsets.only(
                  left: 16.0.wp,
                  top: 3.0.wp,
                  right: 16.0.wp,
                ),
                child: Row(
                  children: [
                    Text("${totalTodos} Tasks",
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 3.0.wp,
                    ),
                    Expanded(
                      child: StepProgressIndicator(
                        totalSteps: totalTodos == 0 ? 1 : totalTodos,
                        currentStep: homeCtrl.createdTodos.length,
                        size: 5,
                        padding: 0,
                        selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [color.withOpacity(0.5), color],
                          ),
                          unselectedGradientColor:LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey[300]!, Colors.grey[300]!],
                          ),
                         )
                      )
                  ],
                ),
              );
            }),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeCtrl.editCtrl,
                autofocus: true,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!,)
                  ),
                  prefixIcon: Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.grey[400],
                    ),
                  suffixIcon: IconButton(
                    onPressed: (){
                      if(homeCtrl.formKey.currentState!.validate()){
                        var success = homeCtrl.addTodo(homeCtrl.editCtrl.text); //TODO implement this
                        if(success){
                          EasyLoading.showSuccess("Added todo item");
                        }
                        else{
                          EasyLoading.showError("Todo item alreasy exists");
                        }
                        homeCtrl.editCtrl.clear();
                      }
                    }, icon:const Icon(Icons.done),),
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Enter your todo item';
                  }
                  else{
                    return null;
                  }
                }
              ),
            ),
            CreatingList(),
            CreatedList(),
          ],
        ),
      ),
    );
  }
}
