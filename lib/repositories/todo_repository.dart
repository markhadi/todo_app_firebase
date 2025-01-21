import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo.dart';

class TodoRepository {
  final CollectionReference _todoCollection;

  TodoRepository({CollectionReference? todoCollection})
      : _todoCollection =
            todoCollection ?? FirebaseFirestore.instance.collection('todos');

  Future<void> addTodo(Todo todo) async {
    await _todoCollection.add(todo.toMap());
  }

  Future<void> updateTodo(Todo todo) async {
    await _todoCollection.doc(todo.id).update(todo.toMap());
  }

  Future<void> deleteTodo(String id) async {
    await _todoCollection.doc(id).delete();
  }

  Stream<List<Todo>> getTodos() {
    return _todoCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Todo.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }
}
