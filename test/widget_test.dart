import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo_app/main.dart';

void main() {
  testWidgets('A test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Add a todo
    await tester.enterText(find.byType(TextField), 'Learn Flutter');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(find.text('0 finished, 1 remaining'), findsOneWidget);
    // Finish the todo
    await tester.tap(find.text('Learn Flutter'));
    await tester.pump();
    expect(find.text('1 finished, 0 remaining'), findsOneWidget);
    // Delete the finished todos
    await tester.tap(find.byTooltip('Delete finished todos'));
    await tester.pump();
    expect(find.text('Learn Flutter'), findsNothing);
    expect(find.text('0 finished, 0 remaining'), findsOneWidget);
  });
}
