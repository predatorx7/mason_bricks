import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:generate_example/widgets/hello_world/hello_world.dart';

void main() {
  testWidgets('Hello world', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HelloWorld(),
        ),
      ),
    );

    expect(find.byType(HelloWorld), findsOneWidget);
  });
}
