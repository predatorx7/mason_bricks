import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import '../pre_gen.dart' as pre_gen;
import 'mock.dart';

void main() {
  group('service', () {
    group('hooks', () {
      test('pre_gen', () async {
        final logger = MockLogger();
        const name = 'test';
        final context = TestableHookContext(
          vars: {
            'schematic': 'service',
            'name': name,
          },
          logger: logger,
        );

        when(
          () => logger.confirm(
            '? Do you want to add methods to your service?',
            defaultValue: any(named: 'defaultValue'),
          ),
        ).thenReturn(false);

        await pre_gen.run(context);

        expect(context.vars['is_schematic_service'], isTrue);
        expect(context.vars['is_schematic_screen'], isFalse);
        expect(context.vars['is_schematic_widget'], isFalse);
        expect(context.vars['use_di_riverpod'], isFalse);
        expect(
          context.vars['methods'],
          containsOnce({'name': 'doSomething', 'type': 'void'}),
        );
      });
    });
  });
}
