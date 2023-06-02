import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'hello_world_provider.dart';
import 'hello_world_state.dart';

// TODO: Add `HelloWorldScreen.navigation` in your `GoRouter`'s routes
class _HelloWorldScreenNavigation {
  final route = GoRoute(
    path: '/hello_world',
    builder: (context, state) {
      return HelloWorldScreen();
    },
  );

  // add other ways create a path for navigating to this screen.
}

class HelloWorldScreen extends ConsumerWidget {
  const HelloWorldScreen({super.key});

  static final navigation = _HelloWorldScreenNavigation();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<HelloWorldScreenState>(
      helloWorldControllerProvider,
      (prev, next) {
        // do something
      },
    );

    final screenState = ref.watch(helloWorldControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(screenState.toString()),
      ),
      body: ElevatedButton(
        onPressed: () {
          final controller = ref.read(helloWorldControllerProvider.notifier);
          controller.doSomething();
        },
        child: Placeholder(),
      ),
    );
  }
}
