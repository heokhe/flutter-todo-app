import 'package:flutter/widgets.dart';

class Todo {
  final String title;
  final String id = DateTime.now().millisecondsSinceEpoch.toString();
  bool isFinished = false;

  Todo(this.title);

  void toggle() {
    isFinished = !isFinished;
  }
}

class Model with ChangeNotifier {
  List<Todo> _todos = [];
  int _finishedCount = 0;

  List<Todo> get todos => _todos;
  int get finishedCount => _finishedCount;
  int get remainingCount => _todos.length - _finishedCount;

  void toggleTodo(int index) {
    final todo = _todos[index];
    todo.toggle();
    _finishedCount += todo.isFinished ? 1 : -1;
    notifyListeners();
  }

  void addTodo(String title) {
    _todos.add(Todo(title));
    notifyListeners();
  }

  void deleteTodo(int index) {
    if (_todos[index].isFinished) _finishedCount--;
    _todos.removeAt(index);
    notifyListeners();
  }

  void deleteFinishedTodos() {
    _todos.retainWhere((todo) => !todo.isFinished);
    _finishedCount = 0;
    notifyListeners();
  }
}
