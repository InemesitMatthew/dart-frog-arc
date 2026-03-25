import 'package:best_practice_crud/repositories/todo_repository.dart';
import 'package:best_practice_crud/services/todo_service.dart';
import 'package:dart_frog/dart_frog.dart';

final _repo = TodoRepository();
final _service = TodoService(_repo);

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(
        provider<TodoService>(
          (context) => _service,
        ),
      );
}
