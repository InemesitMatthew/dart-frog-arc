import 'package:auth_app/user.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

/// An authenticator for the application.
class Authenticator {
  static final _users = {
    'john': User(
      id: '1',
      name: 'John Doe',
      password: 'john123',
    ),
    'jack': User(
      id: '2',
      name: 'Jack Doe',
      password: 'jack123',
    ),
    'Senmid': User(
      id: '3',
      name: 'Sen mid',
      password: 'Jada@1750',
    ),
  };

  static const _passwords = {
    // ⚠️ Never store user's password in plain text,
    // these values are in plain text
    // just for the sake of the tutorial.
    'john': 'john123',
    'jack': 'jack123',
    'Senmid': 'Jada@1750',
  };

  /// Finds a user by their username and password.
  User? findByUsernameAndPassword({
    required String username,
    required String password,
  }) {
    final user = _users[username];
    if (user != null && _passwords[username] == password) {
      return user;
    }
    return null;
  }

  /// Verifies a token and returns the user if it is valid.
  User? verifyToken(String token) {
    try {
      final payload = JWT.verify(
        token,
        SecretKey('123'),
      );
      final payloadData = payload.payload as Map<String, dynamic>;
      final username = payloadData['username'] as String;
      return _users[username];
    } catch (_) {
      return null;
    }
  }

  /// Generates a token for a user.
  String generateToken({
    required String username,
    required User user,
  }) {
    final jwt = JWT(
      {
        'id': user.id,
        'name': user.name,
        'username': username,
      },
    );
    return jwt.sign(
      SecretKey('123'),
    );
  }
}
