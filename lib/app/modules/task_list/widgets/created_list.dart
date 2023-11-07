import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_constructor/app/core/utils/extensions.dart';

import '../../../core/values/colors.dart';
import '../../home/controllers/home_controller.dart';

class CreatedList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  CreatedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.createdTodos.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(
                  vertical: 2.0.wp,
                  horizontal: 5.0.wp,
                ),
                child: Text(
                  "Completed(${homeCtrl.createdTodos.length})",
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...homeCtrl.createdTodos
                  .map(
                    (elem) => Dismissible(
                      key: ObjectKey(elem),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => homeCtrl.deleteCreatedTodo(elem),
                      background: Container(
                        color: Colors.greenAccent.withOpacity(0.8),
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding:  EdgeInsets.only(right: 5.0.wp,),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),

                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(
                          vertical: 3.0.wp,
                          horizontal: 9.0.wp,
                          ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: Icon(Icons.done,
                                    color: Colors.green,),
                              
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 4.0.wp,),
                              child: Text(
                                elem['title'],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList()
            ],
          )
        : Container());
  }
}
