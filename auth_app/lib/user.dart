/// A user of the application.
class User {
  /// Creates a new user.
  User({
    required this.id,
    required this.name,
    required this.password,
  });

  /// The unique identifier of the user.
  final String id;

  /// The name of the user.
  final String name;

  /// The password of the user.
  final String password;

  /// Safe for API responses (does not include [password]).
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
