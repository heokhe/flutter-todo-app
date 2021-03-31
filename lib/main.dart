import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model.dart';
import 'package:todo_app/form.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => Model(),
    child: MyApp(),
  ));
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
      background: Container(color: Colors.red.shade600),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 8),
        onTap: () => onToggle(),
        leading: AbsorbPointer(
            child: SizedBox(
                width: 48,
                child: Checkbox(
                    activeColor: Theme.of(context).accentColor,
                    checkColor: Theme.of(context).accentIconTheme.color,
                    value: todo.isFinished,
                    onChanged: (bool? _) => {}))),
        title: Text(todo.title),
      ),
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

class TodoCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.read<Model>();
    final finishedCount = model.finishedCount;
    final remainingCount = model.remainingCount;
    return Padding(
        padding: EdgeInsets.all(16),
        child: Text('$finishedCount finished, $remainingCount remaining',
            style: Theme.of(context).textTheme.caption));
  }
}

class ClearButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.read<Model>();
    final finishedCount = model.finishedCount;
    final deleteFinishedTodos = model.deleteFinishedTodos;
    return IconButton(
        tooltip: 'Delete finished todos',
        icon: Icon(Icons.cleaning_services_outlined),
        onPressed: finishedCount > 0 ? deleteFinishedTodos : null);
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<Model>();
    final todos = model.todos;
    return Scaffold(
        appBar:
            AppBar(title: Text('Flutter Todo App'), actions: [ClearButton()]),
        body: ListWrapper(
            child: ListView(children: [
          for (var i = 0; i < todos.length; i++)
            TodoItem(
              todo: todos[i],
              onToggle: () => model.toggleTodo(i),
              onDelete: () => model.deleteTodo(i),
            ),
          TodoForm(),
          TodoCounter(),
        ])));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final darkTheme = ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        accentColor: Colors.tealAccent);
    final lightTheme =
        ThemeData(primarySwatch: Colors.deepPurple, accentColor: Colors.teal);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Todo App',
        color: Colors.deepPurple,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: MyPage());
  }
}
