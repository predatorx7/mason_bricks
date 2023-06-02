import 'dart:async';

abstract class HelloWorldService {
  // Private constructor for not allowing this class to be extended.
  const HelloWorldService._();

  /// A description for doSomething
  FutureOr<void> doSomething();
}
