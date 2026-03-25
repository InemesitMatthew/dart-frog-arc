import 'package:dart_frog/dart_frog.dart';
import 'package:simple_crud/todo_store.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  // GET /todos -> List all todos
  if (request.method == HttpMethod.get) {
    return Response.json(
      body: {'message': 'Todos fetched successfully.', 'todos': todos},
      statusCode: 201,
    );
  }

  // POST /todos -> Create a new todo
  if (request.method == HttpMethod.post) {
    final body = await request.json() as Map<String, dynamic>;

    final newTodo = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': body['title'],
      'isCompleted': false,
    };

    todos.add(newTodo);

    return Response.json(
      body: {'message': 'Todo created successfully.', 'todo': newTodo},
      statusCode: 201,
    );
  }
  return Response(body: 'Method not allowed', statusCode: 405);
}
