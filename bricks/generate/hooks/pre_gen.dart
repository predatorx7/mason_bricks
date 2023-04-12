import 'package:mason/mason.dart';

import 'utils.dart';

Future<void> run(HookContext context) async {
  final schematic = context.vars['schematic'] as String;

  final di = context.vars['di'] as String;
  final name = context.vars['name'] as String;

  final logger = context.logger;

  final packageName = getPackageName();

  logger.info('Generating for package "$packageName"');

  context.vars = {
    ...context.vars,
    'is_schematic_screen': schematic == 'screen',
    'is_schematic_service': schematic == 'service',
    'use_di_riverpod': di == 'riverpod',
    'package_name': packageName,
  };

  if (schematic == 'screen') {
    final screenRoutePath = logger.prompt(
      'What is the route path for the screen?',
      defaultValue: '/${name.snakeCase}',
    );
    context.vars = {
      ...context.vars,
      'screen_route_path': screenRoutePath,
    };
  }

  if (schematic == 'service') {
    final methods = <Map<String, dynamic>>[];

    if (!logger.confirm(
      '? Do you want to add methods to your service?',
      defaultValue: true,
    )) {
      methods.add({
        'name': 'doSomething',
        'type': 'void',
      });
    } else {
      logger
        ..alert(lightYellow.wrap('enter "e" to exit adding methods'))
        ..alert('Format: returnType methodName e.g, String myMethod:');

      while (true) {
        final method = logger
            .prompt(':')
            .replaceAll(
              RegExp(r'\s+'),
              ' ',
            )
            .trim();
        if (method.toLowerCase() == 'e') {
          break;
        }

        if (!method.contains(' ')) {
          logger.alert(
            // ignore: lines_longer_than_80_chars
            'That was not a valid format -> returnType methodName e.g, String myMethod',
          );
          continue;
        }

        final splitProperty = method.split(' ');
        final propertyType = splitProperty[0];
        final propertyName = splitProperty[1];
        methods.add({
          'name': propertyName,
          'type': propertyType,
        });
      }
    }
    context.vars = {
      ...context.vars,
      'methods': methods,
    };
  }
}
