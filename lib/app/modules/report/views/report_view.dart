import 'package:flutter/material.dart';
import '../../home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:project_constructor/app/core/utils/extensions.dart';


class ReportView extends GetView<HomeController> {
  final homeCtrl = Get.find<HomeController>();
  ReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() {
        var createdTasks = homeCtrl.getTotalTasks();
        var completedTasks = homeCtrl.getTotalCompletedTasks();
        var liveTasks = createdTasks - completedTasks;
        var percent = (completedTasks / createdTasks * 100).toStringAsFixed(0);
        return ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 90.0.wp,
              ),
              child: IconButton(
                  splashRadius: 30,
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back)),
            ),
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                "Общая информация",
                style: TextStyle(
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(thickness: 2,),
            Padding(
              padding:  EdgeInsets.all(5.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatus(Colors.green, liveTasks, 'Текущие'),
                   _buildStatus(Colors.orange, completedTasks, 'Завершены'),
                   _buildStatus(Colors.blue, createdTasks, 'Всего создано'),
                ],
              ),
            ),
          ],
        );
      })),
    );
  }
}

Row _buildStatus(Color color, int number, String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 3.0.wp,
        width: 3.0.wp,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 0.5.wp,
            color: color,
          )
        ),
      ),
      SizedBox(
        width: 3.0.wp,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${number}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0.sp,
            ),
          ),
          SizedBox(
            height: 2.0.wp,
          ),
          Text(text,
            style: TextStyle(
              fontSize: 11.0.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ],
  );
}
