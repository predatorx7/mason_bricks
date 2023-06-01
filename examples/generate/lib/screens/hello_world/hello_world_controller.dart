import 'package:state_notifier/state_notifier.dart';

import 'hello_world_state.dart';

class HelloWorldController extends StateNotifier<HelloWorldScreenState> {
  HelloWorldController(this._ref) : super(const HelloWorldScreenState());

  final Ref _ref;

  void doSomething() {
    // TODO: implement
  }
}
