import 'dart:async';

abstract class HelloWorldService {
  // Private constructor for not allowing this class to be extended.
  const HelloWorldService._();

  /// A description for sayHello
  FutureOr<String> sayHello();

  /// A description for didGreet
  FutureOr<bool> didGreet();
}
