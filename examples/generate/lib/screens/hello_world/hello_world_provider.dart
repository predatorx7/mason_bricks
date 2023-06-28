import 'package:riverpod/riverpod.dart';

import 'hello_world_controller.dart';
import 'hello_world_data.dart';

final helloWorldControllerProvider = StateNotifierProvider.autoDispose<
    HelloWorldController, HelloWorldScreenState>((ref) {
  return HelloWorldController(ref);
});
