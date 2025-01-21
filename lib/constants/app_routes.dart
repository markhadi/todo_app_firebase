import 'package:get/get.dart';
import '../bindings/todo_binding.dart';
import '../views/add_edit_todo_view.dart';
import '../views/home_view.dart';

class AppRoutes {
  static const String home = '/';
  static const String addEditTodo = '/add_edit_todo';
  static final routes = [
    GetPage(
      name: home,
      page: () => HomeView(),
      binding: TodoBinding(),
    ),
    GetPage(
      name: addEditTodo,
      page: () => AddEditTodoView(),
      binding: TodoBinding(),
    ),
  ];
}
