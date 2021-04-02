import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model.dart';

class TodoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addTodo = context.read<Model>().addTodo;
    TextEditingController controller = TextEditingController();
    return ListTile(
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      leading: SizedBox(
          width: 48, child: Center(child: Icon(Icons.add_circle_outline))),
      title: TextField(
        controller: controller,
        keyboardAppearance: Theme.of(context).brightness,
        onSubmitted: (text) {
          if (text.length > 0) {
            addTodo(text);
            controller.clear();
          }
        },
        decoration: InputDecoration(
            hintText: 'Add a new todo, e.g. go shopping...',
            border: InputBorder.none),
      ),
    );
  }
}
