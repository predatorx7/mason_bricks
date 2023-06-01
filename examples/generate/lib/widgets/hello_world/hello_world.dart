import 'package:flutter/material.dart';

import 'hello_world_theme.dart';
export 'hello_world_theme.dart';


class HelloWorld extends StatelessWidget {
  const HelloWorld({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = HelloWorldTheme.of(context);
    return Text(theme.helloWorldProperty.toString());
  }
}
