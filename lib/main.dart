import 'package:flutter/material.dart';
import 'package:flutter_starter_web/todo.dart';
import 'package:flutter_starter_web/form.dart';

void main() {
  runApp(MyApp());
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  final void Function() onToggle;
  final Key? key;

  TodoItem({required this.todo, required this.onToggle, this.key});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        key: key,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Theme.of(context).accentColor,
        value: todo.isFinished,
        title: Text(todo.title,
            style: todo.isFinished
                ? TextStyle(decoration: TextDecoration.lineThrough)
                : null),
        onChanged: (bool? _) => onToggle());
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
      var todo = _todos[index];
      todo.toggle();
      if (todo.isFinished) {
        _finishedCount++;
      } else {
        _finishedCount--;
      }
    });
  }

  void _addTodo(String title) => setState(() => _todos.add(Todo(title)));

  void _deleteFinishedTodos() {
    setState(() {
      _todos.retainWhere((todo) => !todo.isFinished);
      _finishedCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo App',
        color: Colors.deepPurple,
        theme: ThemeData(
            primarySwatch: Colors.deepPurple, accentColor: Colors.tealAccent),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Todo App'),
              actions: [
                IconButton(
                    tooltip: 'Delete finished todos',
                    icon: Icon(Icons.cleaning_services_outlined),
                    onPressed: _finishedCount > 0 ? _deleteFinishedTodos : null)
              ],
            ),
            body: ListView(
              children: [
                TodoForm(onSubmit: _addTodo),
                Divider(),
                for (int i = 0; i < _todos.length; i++)
                  TodoItem(
                      todo: _todos[i],
                      onToggle: () => _toggleTodo(i),
                      key: Key(_todos[i].title)),
                _todos.length == 0
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(32, 72, 32, 0),
                        child: Text(
                          'Looks like you have nothing to do.',
                          style: Theme.of(context).textTheme.headline5,
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ))
                    : Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                            '$_finishedCount finished, ${_todos.length - _finishedCount} remaining',
                            style: Theme.of(context).textTheme.caption))
              ],
            )));
  }
}
