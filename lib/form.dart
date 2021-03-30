import 'package:flutter/material.dart';

class TodoForm extends StatelessWidget {
  final void Function(String title) onSubmit;
  TodoForm({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return ListTile(
      leading: Padding(
          padding: EdgeInsets.only(left: 4),
          child: Icon(Icons.add_circle_outline)),
      title: TextField(
        autofocus: true,
        controller: controller,
        keyboardAppearance: Theme.of(context).brightness,
        onSubmitted: (text) {
          if (text.length > 0) {
            onSubmit(text);
            controller.clear();
          }
        },
        decoration: InputDecoration.collapsed(
            hintText: 'Add a new todo, e.g. go shopping...',
            border: InputBorder.none),
      ),
    );
  }
}
