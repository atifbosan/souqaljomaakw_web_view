import 'package:get/get.dart';

import '../../../app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed(Routes.MYWEB);
    });
    super.onInit();
  }
}
