/// A model for a todo item
class Todo {
  /// Create a new todo item
  const Todo({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  /// Convert JSON -> Todo
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }

  /// The unique identifier for the todo item
  final String id;

  /// The title of the todo item
  final String title;

  /// Whether the todo item is completed
  final bool isCompleted;

  /// Convert Todo -> JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}
