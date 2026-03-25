import 'package:best_practice_crud/services/todo_service.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  final service = context.read<TodoService>();
  final request = context.request;

  try {
    if (request.method == HttpMethod.get) {
      final todo = service.getTodo(id);
      return Response.json(body: todo.toJson());
    }

    if (request.method == HttpMethod.put) {
      final body = await request.json() as Map<String, dynamic>;

      final updated = service.updateTodo(
        id,
        title: body['title'] as String?,
        isCompleted: body['isCompleted'] as bool?,
      );

      return Response.json(body: updated.toJson());
    }

    if (request.method == HttpMethod.delete) {
      service.deleteTodo(id);

      return Response.json(
        body: {'message': 'Deleted successfully'},
      );
    }

    return Response(statusCode: 405);
  } catch (e) {
    return Response.json(
      body: {'error': e.toString()},
      statusCode: 404,
    );
  }
}
