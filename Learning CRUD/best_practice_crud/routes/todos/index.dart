import 'package:best_practice_crud/services/todo_service.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final service = context.read<TodoService>();
  final request = context.request;

  try {
    if (request.method == HttpMethod.get) {
      final todos = service.getTodos();
      return Response.json(body: todos.map((todo) => todo.toJson()).toList());
    }
    if (request.method == HttpMethod.post) {
      final body = await request.json() as Map<String, dynamic>;

      final todo = service.createTodo(body['title'] as String);

      return Response.json(
        body: todo.toJson(),
        statusCode: 201,
      );
    }
    return Response.json(
      body: {'error': 'Method not allowed'},
      statusCode: 405,
    );
  } catch (e) {
    return Response.json(
      body: {'error': e.toString()},
      statusCode: 400,
    );
  }
}
