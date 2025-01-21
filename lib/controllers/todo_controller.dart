import 'package:get/get.dart';
import '../models/todo.dart';
import '../repositories/todo_repository.dart';
import '../utils/snackbar_helper.dart';

class TodoController extends GetxController {
  final TodoRepository _todoRepository;
  final SnackbarHelper _snackbarHelper;

  TodoController(
    this._todoRepository,
    this._snackbarHelper,
  );

  var todos = <Todo>[].obs;
  var isLoading = false.obs;
  var hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  void fetchTodos() {
    isLoading.value = true;
    hasError.value = false;
    _todoRepository.getTodos().listen((data) {
      todos.value = data;
      isLoading.value = false;
    }, onError: (error) {
      isLoading.value = false;
      hasError.value = true;
      _snackbarHelper.showSnackbar(
        title: 'Error',
        message: error.toString(),
        status: Status.error,
      );
    });
  }

  Future<void> addTodo(Todo todo) async {
    try {
      await _todoRepository.addTodo(todo);
      _snackbarHelper.showSnackbar(
        title: 'Success',
        message: 'Task successfully added',
        status: Status.success,
      );
    } catch (e) {
      _snackbarHelper.showSnackbar(
        title: 'Error',
        message: e.toString(),
        status: Status.error,
      );
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await _todoRepository.updateTodo(todo);
      _snackbarHelper.showSnackbar(
        title: 'Success',
        message: 'Task updated successfully',
        status: Status.success,
      );
    } catch (e) {
      _snackbarHelper.showSnackbar(
        title: 'Error',
        message: e.toString(),
        status: Status.error,
      );
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _todoRepository.deleteTodo(id);
      _snackbarHelper.showSnackbar(
        title: 'Success',
        message: 'Task successfully deleted',
        status: Status.success,
      );
    } catch (e) {
      _snackbarHelper.showSnackbar(
        title: 'Error',
        message: e.toString(),
        status: Status.error,
      );
    }
  }

  Future<void> toggleCompletion(Todo todo) async {
    await updateTodo(todo.copyWith(isCompleted: !todo.isCompleted));
  }
}
