import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_constructor/app/data/services/storage/services.dart';

import 'app/routes/app_pages.dart';

import 'package:get_storage/get_storage.dart';

void main() async {
 await GetStorage.init();
 await Get.putAsync(() => StorageService().init());
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
