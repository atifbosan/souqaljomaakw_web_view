import 'package:get/get.dart';
import '../../presentations/home/bindings/home_binding.dart';
import '../../presentations/home/views/home_view.dart';
import '../../presentations/webpage/bindings/my_web_bindings.dart';
import '../../presentations/webpage/views/my_web_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const WEBINTIAL = Routes.MYWEB;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.EXAMPLE_TWO,
      page: () => MyWebView(),
      binding: MyWebBinding(),
    ),
  ];
}
