
import 'package:mason/mason.dart';
import 'package:mocktail/mocktail.dart';

class MockLogger extends Mock implements Logger {}

class TestableHookContext extends HookContext {
  TestableHookContext({
    required this.vars,
    required this.logger,
  });

  @override
  Map<String, dynamic> vars;

  @override
  final Logger logger;
}
