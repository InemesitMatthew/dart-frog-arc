/* import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../routes/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('GET /', () {
    test('responds with a 200 and "Welcome to Dart Frog!".', () async {
      // Arrange
      final context = _MockRequestContext();

      // Act
      final response = route.onRequest(context);

      // Assert
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.body(), completion(equals('Welcome to Dart Frog!')));
    });
  });
}
 */