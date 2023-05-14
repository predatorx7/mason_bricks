import 'dart:async';

import 'hello_world_service.dart';

class HelloWorldServiceImpl implements HelloWorldService {
  const HelloWorldServiceImpl();

  @override
  FutureOr<String> sayHello() {
    throw UnimplementedError();
  }

  @override
  FutureOr<bool> didGreet() {
    throw UnimplementedError();
  }
}
