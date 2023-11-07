import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo/main.dart';

void main() {
  testWidgets('ToDo List Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(title: 'ToDo List'));

    // Verify that the app starts with an empty list.
    expect(find.text('ToDo List'), findsOneWidget);
    expect(find.text('New Task'), findsOneWidget);

    // Add a new task and verify it is in the list.
    await tester.enterText(find.byType(TextField), 'Sample Task');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('Sample Task'), findsOneWidget);

    
  });
}
