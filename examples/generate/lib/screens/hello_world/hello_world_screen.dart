import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'hello_world_provider.dart';
import 'hello_world_data.dart';

// TODO: Add `HelloWorldScreen.navigation.route` in your `GoRouter`'s routes
class _HelloWorldRouteData {
  final route = GoRoute(
    path: '/hello_world/:foo',
    builder: (context, state) {
      return HelloWorldScreen();
    },
  );

  /// Use as
  /// ```dart
  /// context.go(HelloWorldScreen.navigation.createUri(
  ///   HelloWorldScreenParams(
  ///     foo: 'foo',
  ///     bar: 'bar',
  ///   ),
  /// ));
  /// ```
  Uri createUri(HelloWorldRouteParams params) {
    return Uri(
      path: '/hello_world/${params.foo}',
      queryParameters: params.queryParameters,
    );
  }

  HelloWorldRouteParams paramsOf(BuildContext context) {
    return HelloWorldRouteParams.of(context);
  }
}

class HelloWorldScreen extends ConsumerWidget {
  const HelloWorldScreen({super.key});

  static final navigation = _HelloWorldRouteData();

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

class HelloWorldRouteParams {
  const HelloWorldRouteParams({
    required String this.foo,
    this.bar,
  });

  HelloWorldRouteParams.fromState(GoRouterState state)
      : foo = state.params['foo'],
        bar = state.queryParams['bar'];

  HelloWorldRouteParams.of(BuildContext context)
      : this.fromState(GoRouterState.of(context));

  final String? foo;
  final String? bar;

  Map<String, String> get pathParameters {
    return {
      if (foo != null) 'foo': foo!,
    };
  }

  Map<String, String> get queryParameters {
    return {
      if (bar != null) 'bar': bar!,
    };
  }
}
