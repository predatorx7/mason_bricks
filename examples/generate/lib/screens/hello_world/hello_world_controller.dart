import 'package:riverpod/riverpod.dart';

import 'hello_world_data.dart';

class HelloWorldController extends StateNotifier<HelloWorldScreenState> {
  HelloWorldController(this._ref) : super(const HelloWorldScreenState());

  final Ref _ref;

  void doSomething() {
    // TODO: implement
  }
}
