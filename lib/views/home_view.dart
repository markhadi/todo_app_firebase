import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_routes.dart';
import '../controllers/todo_controller.dart';

class HomeView extends StatelessWidget {
  final TodoController _todoController = Get.find<TodoController>();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (_todoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_todoController.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Failed to load task.'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _todoController.fetchTodos();
                  },
                  child: const Text('Try again'),
                ),
              ],
            ),
          );
        }
        if (_todoController.todos.isEmpty) {
          return const Center(child: Text('There are no tasks.'));
        }
        return ListView.builder(
          itemCount: _todoController.todos.length,
          itemBuilder: (context, index) {
            final todo = _todoController.todos[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(
                  todo.title,
                  style: TextStyle(
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                subtitle: Text(todo.description),
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) {
                    _todoController.toggleCompletion(todo);
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _todoController.deleteTodo(todo.id);
                  },
                ),
                onTap: () {
                  Get.toNamed(AppRoutes.addEditTodo, arguments: todo);
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addEditTodo);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
