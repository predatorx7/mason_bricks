import 'package:mason/mason.dart';

import 'recase.dart';

Future<void> run(HookContext context) async {
  final schematic = context.vars['schematic'] as String;

  final di = context.vars['di'] as String;
  final name = context.vars['name'] as String;
  final screenRoutePath = context.vars['screenRoutePath'] as String?;

  context.vars = {
    ...context.vars,
    'screen_route_path': screenRoutePath != null && screenRoutePath.isNotEmpty ? screenRoutePath : '/${ReCase(name).snakeCase}',
    'is_schematic_screen': schematic == 'screen',
    'is_schematic_service': schematic == 'service',
    'use_di_riverpod': di == 'riverpod',
  };
}
