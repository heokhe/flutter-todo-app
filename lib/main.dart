import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';
import 'package:todo_app/form.dart';

void main() {
  runApp(MyApp());
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  final void Function() onToggle;
  final void Function() onDelete;

  TodoItem(
      {required this.todo, required this.onToggle, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.horizontal,
      onDismissed: (_) => onDelete(),
      child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Theme.of(context).accentColor,
          checkColor: Theme.of(context).accentIconTheme.color,
          value: todo.isFinished,
          title: Text(todo.title),
          onChanged: (bool? _) => onToggle()),
    );
  }
}

class ListWrapper extends StatelessWidget {
  final Widget child;

  ListWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width >= 600) {
      return Center(
          child: Container(
              constraints: BoxConstraints(maxWidth: 600 - 2 * 24),
              child: Card(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(),
                  child: child)));
    } else {
      return child;
    }
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Todo> _todos = [];
  int _finishedCount = 0;

  void _toggleTodo(int index) {
    setState(() {
      final todo = _todos[index];
      todo.toggle();
      _finishedCount += todo.isFinished ? 1 : -1;
    });
  }

  void _addTodo(String title) => setState(() => _todos.add(Todo(title)));

  void _deleteTodo(int index) {
    setState(() {
      if (_todos[index].isFinished) _finishedCount--;
      _todos.removeAt(index);
    });
  }

  void _deleteFinishedTodos() {
    setState(() {
      _todos.retainWhere((todo) => !todo.isFinished);
      _finishedCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final counter = Padding(
        padding: EdgeInsets.all(16),
        child: Text(
            '$_finishedCount finished, ${_todos.length - _finishedCount} remaining',
            style: Theme.of(context).textTheme.caption));

    final appBar = AppBar(
              title: Text('Flutter Todo App'),
              actions: [
                IconButton(
                    tooltip: 'Delete finished todos',
                    icon: Icon(Icons.cleaning_services_outlined),
                    onPressed: _finishedCount > 0 ? _deleteFinishedTodos : null)
              ],
    );

    final darkTheme = ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        accentColor: Colors.tealAccent);
    final lightTheme =
        ThemeData(primarySwatch: Colors.deepPurple, accentColor: Colors.teal);

    return MaterialApp(
        title: 'Flutter Todo App',
        color: Colors.deepPurple,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: Scaffold(
            appBar: appBar,
            body: ListWrapper(
                child: ListView(children: [
                          for (int i = 0; i < _todos.length; i++)
                            TodoItem(
                              todo: _todos[i],
                              onToggle: () => _toggleTodo(i),
                              onDelete: () => _deleteTodo(i),
                            ),
                          TodoForm(onSubmit: _addTodo),
              counter
            ]))));
  }
}
