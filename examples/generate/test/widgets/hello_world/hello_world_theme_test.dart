import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:generate_example/widgets/hello_world/hello_world.dart';

void main() {
  test('HelloWorldThemeData copyWith, ==, hashCode basics', () {
    expect(const HelloWorldThemeData(), const HelloWorldThemeData().copyWith());
    expect(const HelloWorldThemeData().hashCode,
        const HelloWorldThemeData().copyWith().hashCode);
  });

  test('HelloWorldThemeData defaults', () {
    const HelloWorldThemeData themeData = HelloWorldThemeData();
    expect(themeData.helloWorldProperty, null);
  });

  testWidgets('Default HelloWorldThemeData debugFillProperties',
      (WidgetTester tester) async {
    final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
    const HelloWorldThemeData().debugFillProperties(builder);

    final List<String> description = builder.properties
        .where((DiagnosticsNode node) => !node.isFiltered(DiagnosticLevel.info))
        .map((DiagnosticsNode node) => node.toString())
        .toList();

    expect(description, <String>[]);
  });

  testWidgets('HelloWorldThemeData implements debugFillProperties',
      (WidgetTester tester) async {
    final fakeObject = Object();

    final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder();
    HelloWorldThemeData(
      helloWorldProperty: fakeObject,
    ).debugFillProperties(builder);

    final List<String> description = builder.properties
        .where((DiagnosticsNode node) => !node.isFiltered(DiagnosticLevel.info))
        .map((DiagnosticsNode node) => node.toString())
        .toList();

    expect(description, <dynamic>[
      allOf(startsWith('helloWorldProperty:'), contains('Object')),
    ]);
  });

  // A test case where the theme is introduced with the HelloWorldTheme widget.
  testWidgets('HelloWorld use Hello world theme', (WidgetTester tester) async {
    const Object fakeObject = Object();

    final HelloWorldThemeData helloWorldTheme = HelloWorldThemeData(
      helloWorldProperty: fakeObject,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: HelloWorldTheme(
          data: helloWorldTheme,
          child: Material(
            child: Column(
              children: <Widget>[
                HelloWorld(),
              ],
            ),
          ),
        ),
      ),
    );

    final Text helloWorldWidget = tester.widget(
      find.descendant(
        of: find.byType(HelloWorld),
        matching: find.byType(Text),
      ),
    );

    expect(helloWorldWidget.data == fakeObject.toString(), isTrue);
  });
}
