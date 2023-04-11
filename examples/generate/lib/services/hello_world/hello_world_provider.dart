import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'hello_world_service.dart';

final helloWorldServiceProvider = Provider((ref) {
    return const HelloWorldService(); 
});
