import 'package:get/get.dart';

import '../controllers/my_web_controller.dart';

class MyWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyWebController>(
      () => MyWebController(),
    );
  }
}
