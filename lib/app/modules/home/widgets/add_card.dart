import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_constructor/app/core/utils/extensions.dart';
import 'package:project_constructor/app/core/values/colors.dart';
import 'package:project_constructor/app/global_widgets/icons.dart';
import 'package:project_constructor/app/modules/home/controllers/home_controller.dart';

import '../../../data/models/task.dart';

class AddCard extends StatelessWidget {
final homeCtrl = Get.find<HomeController>();
AddCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: "Группа задания",
             content: Form(
              key: homeCtrl.formKey,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      controller: homeCtrl.editCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Заголовок",
                      ), 
                      validator: (value){
                        if(value == null || value.trim().isEmpty){
                          return "Введите заголовок";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                    child: Wrap(
                      spacing: 2.0.wp,
                      
                      children: 
                        icons.map((elem) => Obx(
                          (){
                            final index = icons.indexOf(elem);
                            return ChoiceChip(
                              selectedColor: Colors.grey[200],
                              pressElevation: 0,
                              backgroundColor: Colors.white12,
                              label: elem,
                               selected: homeCtrl.chipIndex.value == index,
                               onSelected: (bool selected){
                                homeCtrl.chipIndex.value = selected ? index : 0;
                               },
                               );
                          }
                        )).toList()
                        ,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      minimumSize: const Size(150,40),

                    ),
                    onPressed: (){
                      if(homeCtrl.formKey.currentState!.validate()){
                        int icon =  icons[homeCtrl.chipIndex.value].icon!.codePoint;
                        String color = icons[homeCtrl.chipIndex.value].color!.toHex();
                        var task = Task(
                          title: homeCtrl.editCtrl.text,
                          icon: icon,
                          color: color,
                        );
                        Get.back();
                        homeCtrl.addTask(task) ?  null: 
                          EasyLoading.showError("Задание уже существует");

                      }
                    },
                     child:const Text("Confirm"),
                    )
                ],
              ),
            ),
          );
          homeCtrl.editCtrl.clear();
          homeCtrl.changeCheapIndex(0);
        },  
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              width: 1.0,
              color: Colors.amber[400]!,
              style: BorderStyle.solid,
              ),
            
          ),
          child: Center(
            child: Icon(Icons.add,
              size: 10.0.wp,
              color: Colors.orange[400],
          ),
        )
        )
    )
    );  
    
  }
}