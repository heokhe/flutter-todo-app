class Todo {
  final String title;
  bool isFinished = false;

  Todo(this.title);

  void toggle() {
    isFinished = !isFinished;
  }
}
