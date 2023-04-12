import 'dart:async';

import 'hello_world_service.dart';

class HelloWorldServiceImpl implements HelloWorldService {
    const HelloWorldServiceImpl();

    
    /// A description for sayHello
    @override
    FutureOr<String> sayHello() {
        throw UnimplementedError();
    }
    
    /// A description for didGreet
    @override
    FutureOr<bool> didGreet() {
        throw UnimplementedError();
    }
    
}
