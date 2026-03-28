import 'dart:io';

import 'package:auth_app/user.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => _onPost(context),
    _ => Future.value(
        Response.json(
          statusCode: HttpStatus.methodNotAllowed,
          body: {
            'error': 'Method not allowed',
          },
        ),
      ),
  };
}

Future<Response> _onPost(RequestContext context) async {
  final task = await context.request.json();
  final user = context.read<User>();
  
  return Response.json(
    body: {
      'recorded_task': task,
      'user_id': user.id,
    },
  );
}
