import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:generate_example/screens/hello_world/hello_world.dart';

class _MyTestApp extends StatelessWidget {
  const _MyTestApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HelloWorldScreen(),
    );
  }
}

void main() {
  testWidgets('Check appbar label smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: _MyTestApp()));

    // Verify that our appbar title has correct label.
    expect(find.text('Hello world'), findsOneWidget);
  });
}
