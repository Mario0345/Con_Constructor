import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_constructor/app/core/utils/extensions.dart';
import 'package:project_constructor/app/modules/home/controllers/home_controller.dart';

class CreatingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  CreatingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.creatingTodos.isEmpty && homeCtrl.createdTodos.isEmpty
          ? Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'assets/images/img.png',
                  fit: BoxFit.none,
                  // width: 35.0.wp,
                ),
                Text('Add task',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0.sp,
                    ))
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...homeCtrl.creatingTodos
                    .map(
                      (elem) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 3.0.wp,
                          horizontal: 7.55.wp,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                fillColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.white),
                                value: elem['done'],
                                onChanged: (value) {
                                  homeCtrl.createdTodo(elem['title']);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                              child: Text(
                                elem['title'],
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
                if (homeCtrl.creatingTodos.isNotEmpty) Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.0.wp),
                  child: const Divider(thickness: 2),
                ),
              ],
            ),
    );
  }
}
