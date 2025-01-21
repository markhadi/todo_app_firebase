import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';
import '../models/todo.dart';

class AddEditTodoView extends StatelessWidget {
  final TodoController _todoController = Get.find<TodoController>();
  final Todo? todo = Get.arguments;

  AddEditTodoView({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _saveTodo() {
    if (_formKey.currentState!.validate()) {
      if (todo == null) {
        final newTodo = Todo(
          id: '',
          title: _titleController.text,
          description: _descriptionController.text,
        );
        _todoController.addTodo(newTodo);
      } else {
        final updatedTodo = todo!.copyWith(
          title: _titleController.text,
          description: _descriptionController.text,
        );
        _todoController.updateTodo(updatedTodo);
      }
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (todo != null) {
      _titleController.text = todo!.title;
      _descriptionController.text = todo!.description;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(todo == null ? 'Add Task' : 'Edit Task'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                style: Theme.of(context).textTheme.bodyMedium,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _saveTodo,
                  child: Text(todo == null ? 'Save' : 'Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
