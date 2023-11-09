import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:project_constructor/app/core/utils/extensions.dart';
import 'package:project_constructor/app/modules/home/controllers/home_controller.dart';

class AddDialog extends StatelessWidget {
  AddDialog({Key? key}) : super(key: key);

  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: homeCtrl.formKey,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(2.0.wp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                    homeCtrl.editCtrl.clear();
                    homeCtrl.changeTask(null);
                  },
                  icon: const Icon(Icons.close),
                ),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    if(homeCtrl.formKey.currentState!.validate()){
                      if(homeCtrl.task.value == null){
                        EasyLoading.showError("Выберите тип");
                      }
                      else{
                        var success = homeCtrl.updateTask(
                          homeCtrl.task.value!,
                          homeCtrl.editCtrl.text,
                        );

                        if(success){
                          EasyLoading.showSuccess("Добавлено");
                          Get.back();
                          homeCtrl.changeTask(null);
                        }
                        else{
                          EasyLoading.showError("Уже существует");
                        }
                        homeCtrl.editCtrl.clear();
                      }
                    }
                  },
                  child: Text(
                    'Готово',
                    style: TextStyle(fontSize: 14.0.sp),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
            child: Text(
              "Новая задача",
              style: TextStyle(
                fontSize: 18.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
            child: TextFormField(
                controller: homeCtrl.editCtrl,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[400]!,
                    ),
                  ),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Введите предмет";
                  } else {
                    return null;
                  }
                }),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 5.0.wp,
              left: 5.0.wp,
              right: 5.0.wp,
              bottom: 2.0.wp,
            ),
            child: Text(
              "Добавить к",
              style: TextStyle(
                fontSize: 14.0.sp,
                color: Colors.grey,
              ),
            ),
          ),
          ...homeCtrl.tasks
              .map(
                (elem) => Obx(
                  () => InkWell(
                    onTap: () => homeCtrl.changeTask(elem),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 3.0.wp,
                        horizontal: 5.0.wp,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                IconData(elem.icon,
                                    fontFamily: 'MaterialIcons'),
                                color: HexColor.fromHex(elem.color),
                              ),
                              SizedBox(
                                width: 3.0.wp,
                              ),
                              Text(
                                elem.title,
                                style: TextStyle(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          if (homeCtrl.task.value == elem)
                            const Icon(Icons.check, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    ));
  }
}
