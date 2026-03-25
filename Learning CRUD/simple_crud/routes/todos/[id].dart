import 'package:dart_frog/dart_frog.dart';
import 'package:simple_crud/todo_store.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  final request = context.request;

  // Find todo
  final index = todos.indexWhere((t) => t['id'] == id);

  if (index == -1) {
    return Response.json(
      body: {'error': 'Todo not found.'},
      statusCode: 404,
    );
  }

  final todo = todos[index];

  // GET /todos/:id -> Get a todo
  if (request.method == HttpMethod.get) {
    return Response.json(
      body: {'message': 'Todo fetched successfully.', 'todo': todo},
      statusCode: 201,
    );
  }

  // PUT /todos/:id -> Update a todo
  if (request.method == HttpMethod.put) {
    final body = await request.json() as Map<String, dynamic>;

    final updatedTodo = {
      'id': id,
      'title': body['title'] ?? todo['title'],
      'isCompleted': body['isCompleted'] ?? todo['isCompleted'],
    };

    todos[index] = updatedTodo;

    return Response.json(
      body: {'message': 'Todo updated successfully.', 'todo': updatedTodo},
      statusCode: 201,
    );
  }

  // DELETE /todos/:id -> Delete a todo
  if (request.method == HttpMethod.delete) {
    todos.removeAt(index);

    return Response.json(
      body: {'message': 'Todo deleted successfully.'},
      statusCode: 201,
    );
  }
  return Response(body: 'Method not allowed', statusCode: 405);
}
