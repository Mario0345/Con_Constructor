import 'package:get/get.dart';
import 'package:project_constructor/app/data/providers/provider.dart';

import '../../../data/services/storage/respository.dart';
import '../controllers/report_controller.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportController>(
      () => ReportController(),
    );
  }
}
