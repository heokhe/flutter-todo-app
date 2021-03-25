class Todo {
  final String title;
  final String id = DateTime.now().millisecondsSinceEpoch.toString();
  bool isFinished = false;

  Todo(this.title);

  void toggle() {
    isFinished = !isFinished;
  }
}
