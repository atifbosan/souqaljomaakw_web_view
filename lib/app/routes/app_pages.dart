import 'package:get/get.dart';

import '../../presentations/splash/bindings/splash_binding.dart';
import '../../presentations/splash/views/splash_view.dart';
import '../../presentations/webpage/bindings/my_web_bindings.dart';
import '../../presentations/webpage/views/my_web_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
  static const WEBINTIAL = Routes.MYWEB;

  static final routes = [
    GetPage(
      name: _Paths.EXAMPLE_TWO,
      page: () => MyWebView(),
      binding: MyWebBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
