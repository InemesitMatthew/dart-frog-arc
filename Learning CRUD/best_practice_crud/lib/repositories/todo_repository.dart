import 'package:best_practice_crud/models/todo.dart';

/// A repository for todo items
class TodoRepository {
  final List<Todo> _todos = [];

  /// Get all todo items
  List<Todo> getAll() => _todos;

  /// Create a new todo item
  Todo create(String title) {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      isCompleted: false,
    );
    _todos.add(todo);
    return todo;
  }

  /// Get a todo item by id
  Todo? getById(String id) {
    return _todos.where((t) => t.id == id).firstOrNull;
  }

  /// Update a todo item
  Todo? update(String id, {String? title, bool? isCompleted}) {
    final index = _todos.indexWhere((t) => t.id == id);

    if (index == -1) return null;

    final updated = Todo(
      id: id,
      title: title ?? _todos[index].title,
      isCompleted: isCompleted ?? _todos[index].isCompleted,
    );

    _todos[index] = updated;
    return updated;
  }

  /// Delete a todo item
  bool delete(String id) {
    final lengthBefore = _todos.length;
    _todos.removeWhere((t) => t.id == id);
    return _todos.length < lengthBefore;
  }
}
