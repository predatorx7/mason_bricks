import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'package:generate_example/services/hello_world/hello_world.dart';

void main() {
  test('all HelloWorldService method completes successfully with any value',
      () {
    // An object that will allow us to read providers
    // Do not share this between tests.
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final service = container.read(helloWorldServiceProvider);

    expectLater(service.sayHello(), completes);
    expectLater(service.didGreet(), completes);
  });
}
