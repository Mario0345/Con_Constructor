  import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_constructor/app/core/utils/extensions.dart';
import 'package:project_constructor/app/data/models/task.dart';
import 'package:project_constructor/app/modules/home/widgets/add_card.dart';
import 'package:project_constructor/app/modules/home/widgets/task_card.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Text("Hello its List!",
            style: TextStyle(
              fontSize: 16.0.sp,
              fontWeight: FontWeight.bold,
            ), 
            ),
            ),
            Obx(() => 
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  ...controller.tasks.map(
                    (elem) => TaskCard(task: elem)
                    ).toList(),
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
    );
  }
}
