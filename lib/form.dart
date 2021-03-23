import 'package:flutter/material.dart';

class TodoForm extends StatelessWidget {
  final void Function(String title) onSubmit;
  TodoForm({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Padding(
        padding: EdgeInsets.all(16),
        child: TextFormField(
          autofocus: true,
          controller: controller,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          onFieldSubmitted: (text) {
            if (text.length > 0) {
              onSubmit(text);
              controller.clear();
            }
          },
          decoration: InputDecoration(
              filled: true,
              labelText: 'New todo',
              hintText: 'Go to shopping, ...',
              border: OutlineInputBorder()),
        ));
  }
}
