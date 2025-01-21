import 'package:get/get.dart';
import '../bindings/todo_binding.dart';
import '../views/home_view.dart';

class AppRoutes {
  static const String home = '/';
  static final routes = [
    GetPage(
      name: home,
      page: () => HomeView(),
      binding: TodoBinding(),
    ),
  ];
}
