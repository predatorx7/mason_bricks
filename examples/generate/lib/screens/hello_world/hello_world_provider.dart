import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'hello_world_controller.dart';
import 'hello_world_state.dart';

final helloWorldControllerProvider = StateNotifierProvider.autoDispose<HelloWorldController, HelloWorldScreenState>((ref) {
  return HelloWorldController(ref); 
});
