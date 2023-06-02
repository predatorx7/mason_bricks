import 'package:riverpod/riverpod.dart';

import 'hello_world_service.dart';
import 'hello_world_service_impl.dart';

final helloWorldServiceProvider = Provider<HelloWorldService>((ref) {
  return const HelloWorldServiceImpl();
});
