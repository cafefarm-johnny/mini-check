class Todo {
  const Todo({
    required this.title,
    required this.isDone,
  });

  final String title;
  final bool isDone;

  Todo copyWith({
    bool? isDone,
  }) {
    return Todo(
      title: title,
      isDone: isDone ?? this.isDone,
    );
  }
}
