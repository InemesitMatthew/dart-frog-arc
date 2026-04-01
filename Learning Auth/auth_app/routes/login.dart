import 'dart:io';

import 'package:auth_app/authenticator.dart';
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
  final Map<String, dynamic> body;
  try {
    final decoded = await context.request.json();
    if (decoded is! Map<String, dynamic>) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {'error': 'Expected a JSON object'},
      );
    }
    body = decoded;
  } catch (_) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {'error': 'Invalid or empty JSON body'},
    );
  }

  final username = body['username'] as String?;
  final password = body['password'] as String?;

  if (username == null || password == null) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'error': 'Invalid request body',
      },
    );
  }

  final authenticator = context.read<Authenticator>();

  final user = authenticator.findByUsernameAndPassword(
    username: username,
    password: password,
  );

  if (user == null) {
    return Response.json(
      statusCode: HttpStatus.unauthorized,
      body: {
        'error': 'Unauthorized',
      },
    );
  } else {
    return Response.json(
      body: {
        'id': user.id,
        'name': user.name,
        'username': username,
        'token': authenticator.generateToken(
          username: username,
          user: user,
        ),
      },
    );
  }
}
