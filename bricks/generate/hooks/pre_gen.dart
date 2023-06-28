import 'package:mason/mason.dart';

import 'path_utils.dart' as path_utils;
import 'pre_gen_values.dart';
import 'utils.dart';

Future<void> run(HookContext context) async {
  final variables = VariablesOf(context);
  final snakeCaseName = variables.name.snakeCase;

  final logger = context.logger;

  context.vars = {
    ...context.vars,
    CreatedVariableNames.makeWidgetTheme: false,
    CreatedVariableNames.methods: null,
  };

  switch (variables.schematic) {
    case SchematicValues.screen:
      final screenRoutePath = logger.prompt(
        'What is the route path for the screen?',
        defaultValue: '/$snakeCaseName',
      );

      final pathParams = <String>[];
      path_utils.patternToRegExp(screenRoutePath, pathParams);
      if (pathParams.isNotEmpty) {
        logger.info('Detected path params: ${pathParams.join(', ')}');
      }

      final queryParameters = <String>[];

      if (logger.confirm(
        '? Do you want to add query parameters to this route?',
      )) {
        logger
          ..alert(lightYellow.wrap('enter "e" to exit adding query params'))
          ..alert('Type query param name:');

        while (true) {
          final queryParameterName = logger
              .prompt(':')
              .replaceAll(
                RegExp(r'\s+'),
                ' ',
              )
              .trim();
          if (queryParameterName.toLowerCase() == 'e') {
            break;
          }

          if (queryParameterName.contains(' ') ||
              queryParameterName.contains(',')) {
            logger.alert(
              // ignore: lines_longer_than_80_chars
              'That was not a valid format -> queryParamName e.g, foo_bar',
            );
            continue;
          }

          queryParameters.add(queryParameterName);
        }
      }

      final generatedPath = path_utils.createGeneratedPath(
        screenRoutePath,
      );

      context.vars = {
        ...context.vars,
        CreatedVariableNames.screenRoutePath: screenRoutePath,
        CreatedVariableNames.screenRoutePathParams: pathParams,
        CreatedVariableNames.screenRouteQueryParams: queryParameters,
        CreatedVariableNames.screenRouteGeneratedPath: generatedPath,
      };
      break;
    case SchematicValues.service:
      final methods = <Map<String, dynamic>>[];

      if (!logger.confirm(
        '? Do you want to add methods to your service?',
        defaultValue: true,
      )) {
        methods.add({
          MethodCreatedVariableNames.name: 'doSomething',
          MethodCreatedVariableNames.type: 'void',
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
            MethodCreatedVariableNames.name: propertyName,
            MethodCreatedVariableNames.type: propertyType,
          });
        }
      }
      context.vars = {
        ...context.vars,
        CreatedVariableNames.methods: methods,
      };
      break;
    case SchematicValues.widget:
      final widgetNeedsTheme = logger.confirm(
        '? Do you want to add an InheritedTheme to your widget?',
        defaultValue: true,
      );
      context.vars = {
        ...context.vars,
        CreatedVariableNames.makeWidgetTheme: widgetNeedsTheme,
      };
      break;
  }

  final packageName = getPackageName();

  logger.info('Generating for package "$packageName"');

  final currentVars = context.vars;

  context.vars = {
    ...currentVars,
    CreatedVariableNames.snakeName: snakeCaseName,
    CreatedVariableNames.packageName: packageName,
    CreatedVariableNames.isSchematicScreen: variables.isScreen,
    CreatedVariableNames.isSchematicService: variables.isService,
    CreatedVariableNames.isSchematicWidget: variables.isWidget,
    CreatedVariableNames.makeScreenTest:
        variables.hasTests && variables.isScreen,
    CreatedVariableNames.makeServiceTest:
        variables.hasTests && variables.isService,
    CreatedVariableNames.makeWidgetTest:
        variables.hasTests && variables.isWidget,
    CreatedVariableNames.useDiRiverpod: variables.isDiRiverpod,
  };
}
