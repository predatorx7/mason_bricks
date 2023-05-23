// MIT License
//
// Original work Copyright (c) 2023 Luke Moody
// Modified work Copyright (c) 2023 Mushaheed Syed
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:mason/mason.dart';

import 'utils.dart';

Future<void> run(HookContext context) async {
  if (!kDebugMode) return _run(context);
  try {
    await _run(context);
  } catch (e, s) {
    context.logger.err('Something went wrong\n$e\n$s');
  }
}

Future<void> _run(HookContext context) async {
  final schematic = context.vars['schematic'] as String;

  final di = context.vars['di'] as String?;
  final name = context.vars['name'] as String;

  final logger = context.logger;

  final packageName = getPackageName();

  logger.info('Generating for package "$packageName"');

  context.vars = {
    ...context.vars,
    'is_schematic_screen': schematic == 'screen',
    'is_schematic_service': schematic == 'service',
    'is_schematic_widget': schematic == 'widget',
    'use_di_riverpod': di == 'riverpod',
    'package_name': packageName,
  };

  switch (schematic) {
    case 'screen':
      final screenRoutePath = logger.prompt(
        'What is the route path for the screen?',
        defaultValue: '/${name.snakeCase}',
      );
      context.vars = {
        ...context.vars,
        'screen_route_path': screenRoutePath,
      };
      break;
    case 'service':
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
      break;
    case 'widget':
      final widgetNeedsTheme = logger.confirm(
        '? Do you want to add an InheritedTheme to your widget?',
        defaultValue: true,
      );
      context.vars = {
        ...context.vars,
        'needs_theme_for_widget': widgetNeedsTheme,
      };
      break;
  }
}
