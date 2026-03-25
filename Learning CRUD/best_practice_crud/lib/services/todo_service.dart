import 'package:best_practice_crud/models/todo.dart';
import 'package:best_practice_crud/repositories/todo_repository.dart';

/// A service for todo items
class TodoService {
  /// Create a new todo service
  const TodoService(this._repo);
  final TodoRepository _repo;

  /// Get all todo items
  List<Todo> getTodos() => _repo.getAll();

  /// Create a new todo item
  Todo createTodo(String title) {
    if (title.isEmpty) {
      throw Exception('Title cannot be empty');
    }
    return _repo.create(title);
  }

  /// Get a todo item by id
  Todo getTodo(String id) {
    final todo = _repo.getById(id);
    if (todo == null) throw Exception('Todo not found');
    return todo;
  }

  /// Update a todo item
  Todo updateTodo(String id, {String? title, bool? isCompleted}) {
    final updated = _repo.update(
      id,
      title: title,
      isCompleted: isCompleted,
    );

    if (updated == null) throw Exception('Todo not found');

    return updated;
  }

  /// Delete a todo item
  void deleteTodo(String id) {
    final deleted = _repo.delete(id);
    if (!deleted) throw Exception('Todo not found');
  }
}
