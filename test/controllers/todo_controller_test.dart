import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app_firebase/controllers/todo_controller.dart';
import 'package:todo_app_firebase/models/todo.dart';
import 'package:todo_app_firebase/repositories/todo_repository.dart';
import 'package:todo_app_firebase/utils/snackbar_helper.dart';

import 'todo_controller_test.mocks.dart';

@GenerateMocks([TodoRepository, SnackbarHelper])
void main() {
  late MockTodoRepository mockTodoRepository;
  late MockSnackbarHelper mockSnackbarHelper;
  late TodoController todoController;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    mockSnackbarHelper = MockSnackbarHelper();
    todoController = TodoController(mockTodoRepository, mockSnackbarHelper);
    Get.testMode = true;
  });

  tearDown(() {
    Get.reset();
  });

  group('TodoController Test', () {
    final testTodo = Todo(
      id: '1',
      title: 'Test Todo',
      description: 'This is a test todo',
      isCompleted: false,
    );

    test('fetchTodos should update todos and isLoading correctly on success',
        () async {
      // Arrange
      when(mockTodoRepository.getTodos()).thenAnswer(
        (_) => Stream.value([testTodo]),
      );

      // Act
      todoController.fetchTodos();

      // Assert
      expect(todoController.isLoading.value, true);
      await Future.delayed(Duration.zero);
      expect(todoController.todos.length, 1);
      expect(todoController.todos[0], testTodo);
      expect(todoController.isLoading.value, false);
      expect(todoController.hasError.value, false);
      verify(mockTodoRepository.getTodos()).called(1);
      verifyNever(mockSnackbarHelper.showSnackbar(
        title: anyNamed('title'),
        message: anyNamed('message'),
        status: anyNamed('status'),
      ));
    });

    test('fetchTodos should handle error and show error snackbar', () async {
      // Arrange
      final error = Exception('Failed to fetch todos');
      when(mockTodoRepository.getTodos()).thenAnswer(
        (_) => Stream.error(error),
      );

      // Act
      todoController.fetchTodos();

      // Assert
      expect(todoController.isLoading.value, true);
      await Future.delayed(Duration.zero);
      expect(todoController.todos.length, 0);
      expect(todoController.isLoading.value, false);
      expect(todoController.hasError.value, true);
      verify(mockTodoRepository.getTodos()).called(1);
      verify(mockSnackbarHelper.showSnackbar(
        title: 'Error',
        message: error.toString(),
        status: Status.error,
      )).called(1);
    });

    test('addTodo should successfully add todo and show success snackbar',
        () async {
      // Arrange
      when(mockTodoRepository.addTodo(testTodo))
          .thenAnswer((_) async => Future.value());

      // Act
      await todoController.addTodo(testTodo);

      // Assert
      verify(mockTodoRepository.addTodo(testTodo)).called(1);
      verify(mockSnackbarHelper.showSnackbar(
        title: 'Success',
        message: 'Task successfully added',
        status: Status.success,
      )).called(1);
    });

    test('addTodo should handle error and show error snackbar', () async {
      // Arrange
      final error = Exception('Failed to add todo');
      when(mockTodoRepository.addTodo(testTodo)).thenThrow(error);

      // Act
      await todoController.addTodo(testTodo);

      // Assert
      verify(mockTodoRepository.addTodo(testTodo)).called(1);
      verify(mockSnackbarHelper.showSnackbar(
        title: 'Error',
        message: error.toString(),
        status: Status.error,
      )).called(1);
    });

    test('updateTodo should successfully update todo and show success snackbar',
        () async {
      // Arrange
      when(mockTodoRepository.updateTodo(testTodo))
          .thenAnswer((_) async => Future.value());

      // Act
      await todoController.updateTodo(testTodo);

      // Assert
      verify(mockTodoRepository.updateTodo(testTodo)).called(1);
      verify(mockSnackbarHelper.showSnackbar(
        title: 'Success',
        message: 'Task updated successfully',
        status: Status.success,
      )).called(1);
    });

    test('updateTodo should handle error and show error snackbar', () async {
      // Arrange
      final error = Exception('Failed to update todo');
      when(mockTodoRepository.updateTodo(testTodo)).thenThrow(error);

      // Act
      await todoController.updateTodo(testTodo);

      // Assert
      verify(mockTodoRepository.updateTodo(testTodo)).called(1);
      verify(mockSnackbarHelper.showSnackbar(
        title: 'Error',
        message: error.toString(),
        status: Status.error,
      )).called(1);
    });

    test('deleteTodo should successfully delete todo and show success snackbar',
        () async {
      // Arrange
      when(mockTodoRepository.deleteTodo(testTodo.id))
          .thenAnswer((_) async => Future.value());

      // Act
      await todoController.deleteTodo(testTodo.id);

      // Assert
      verify(mockTodoRepository.deleteTodo(testTodo.id)).called(1);
      verify(mockSnackbarHelper.showSnackbar(
        title: 'Success',
        message: 'Task successfully deleted',
        status: Status.success,
      )).called(1);
    });

    test('deleteTodo should handle error and show error snackbar', () async {
      // Arrange
      final error = Exception('Failed to delete todo');
      when(mockTodoRepository.deleteTodo(testTodo.id)).thenThrow(error);

      // Act
      await todoController.deleteTodo(testTodo.id);

      // Assert
      verify(mockTodoRepository.deleteTodo(testTodo.id)).called(1);
      verify(mockSnackbarHelper.showSnackbar(
        title: 'Error',
        message: error.toString(),
        status: Status.error,
      )).called(1);
    });

    test('toggleCompletion should toggle isCompleted and update todo',
        () async {
      // Arrange
      final toggledTodo = testTodo.copyWith(isCompleted: !testTodo.isCompleted);
      when(mockTodoRepository.updateTodo(any))
          .thenAnswer((_) async => Future.value());

      // Act
      await todoController.toggleCompletion(testTodo);

      // Assert
      verify(mockTodoRepository.updateTodo(argThat(
        isA<Todo>()
            .having((t) => t.id, 'id', testTodo.id)
            .having((t) => t.title, 'title', testTodo.title)
            .having((t) => t.description, 'description', testTodo.description)
            .having(
                (t) => t.isCompleted, 'isCompleted', toggledTodo.isCompleted),
      ))).called(1);
      verify(mockSnackbarHelper.showSnackbar(
        title: 'Success',
        message: 'Task updated successfully',
        status: Status.success,
      )).called(1);
    });

    test('toggleCompletion should handle error and show error snackbar',
        () async {
      // Arrange
      final toggledTodo = testTodo.copyWith(isCompleted: !testTodo.isCompleted);
      final error = Exception('Failed to toggle completion');
      when(mockTodoRepository.updateTodo(any)).thenThrow(error);

      // Act
      await todoController.toggleCompletion(testTodo);

      // Assert
      verify(mockTodoRepository.updateTodo(argThat(
        isA<Todo>()
            .having((t) => t.id, 'id', testTodo.id)
            .having((t) => t.title, 'title', testTodo.title)
            .having((t) => t.description, 'description', testTodo.description)
            .having(
                (t) => t.isCompleted, 'isCompleted', toggledTodo.isCompleted),
      ))).called(1);
      verify(mockSnackbarHelper.showSnackbar(
        title: 'Error',
        message: error.toString(),
        status: Status.error,
      )).called(1);
    });
  });
}
