import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import '../pre_gen.dart' as pre_gen;
import 'mock.dart';

void main() {
  group('screen', () {
    group('hooks', () {
      test('pre_gen', () async {
        final logger = MockLogger();
        const name = 'test';
        final context = TestableHookContext(
          vars: {
            'schematic': 'screen',
            'name': name,
          },
          logger: logger,
        );

        when(
          () => logger.prompt(
            'What is the route path for the screen?',
            defaultValue: any(named: 'defaultValue', that: equals('/$name')),
            hidden: any(named: 'defaultValue'),
          ),
        ).thenReturn('/$name');

        when(
          () => logger.confirm(
            '? Do you want to add query parameters to this route?',
            defaultValue: any(named: 'defaultValue', that: equals(false)),
          ),
        ).thenReturn(false);

        await pre_gen.run(context);

        expect(context.vars['is_schematic_screen'], isTrue);
        expect(context.vars['is_schematic_service'], isFalse);
        expect(context.vars['is_schematic_widget'], isFalse);
        expect(context.vars['screen_route_path'], '/$name');
        expect(context.vars['screen_route_path_params'], isEmpty);
        expect(context.vars['screen_route_query_params'], isEmpty);
        expect(context.vars['use_di_riverpod'], isFalse);
      });
    });
  });
}
