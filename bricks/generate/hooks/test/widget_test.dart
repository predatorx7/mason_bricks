import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import '../pre_gen.dart' as pre_gen;
import 'mock.dart';

void main() {
  group('widget', () {
    group('hooks', () {
      test('pre_gen', () async {
        final logger = MockLogger();
        const name = 'test';
        final context = TestableHookContext(
          vars: {
            'schematic': 'widget',
            'name': name,
          },
          logger: logger,
        );

        when(
          () => logger.confirm(
            '? Do you want to add an InheritedTheme to your widget?',
            defaultValue: any(named: 'defaultValue'),
          ),
        ).thenReturn(true);

        await pre_gen.run(context);

        expect(context.vars['is_schematic_widget'], isTrue);
        expect(context.vars['is_schematic_screen'], isFalse);
        expect(context.vars['is_schematic_service'], isFalse);
        expect(context.vars['use_di_riverpod'], isFalse);
        expect(context.vars['make_widget_theme'], isTrue);
      });
    });
  });
}
