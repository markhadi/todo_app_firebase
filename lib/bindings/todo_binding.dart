import 'package:get/get.dart';
import '../controllers/todo_controller.dart';
import '../repositories/todo_repository.dart';
import '../utils/snackbar_helper.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoRepository>(() => TodoRepository());
    Get.lazyPut<SnackbarHelper>(() => SnackbarHelper());
    Get.lazyPut<TodoController>(
      () => TodoController(
        Get.find<TodoRepository>(),
        Get.find<SnackbarHelper>(),
      ),
    );
  }
}
