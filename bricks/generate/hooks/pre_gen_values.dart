import 'package:mason/mason.dart';

class VariablesOf {
  VariablesOf(this.context);

  final HookContext context;

  String get schematic => context.vars['schematic'] as String;
  String? get di => context.vars['di'] as String?;
  String get name => context.vars['name'] as String;
  bool get hasTests => context.vars['has_tests'] == true;

  bool get isScreen => schematic == SchematicValues.screen;
  bool get isService => schematic == SchematicValues.service;
  bool get isWidget => schematic == SchematicValues.widget;
  bool get useDiRiverpod => di == DiValues.riverpod;
}

class SchematicValues {
  SchematicValues._();

  static const String screen = 'screen';
  static const String service = 'service';
  static const String widget = 'widget';
}

class DiValues {
  DiValues._();

  static const String riverpod = 'riverpod';
}

class CreatedVariableNames {
  CreatedVariableNames._();

  static const String isSchematicScreen = 'is_schematic_screen';
  static const String isSchematicService = 'is_schematic_service';
  static const String isSchematicWidget = 'is_schematic_widget';
  static const String useDiRiverpod = 'use_di_riverpod';
  static const String packageName = 'package_name';
  static const String makeWidgetTheme = 'make_widget_theme';
  static const String methods = 'methods';
  static const String screenRoutePath = 'screen_route_path';
  static const String snakeName = 'snake_name';
  static const String makeScreenTest = 'make_screen_test';
  static const String makeServiceTest = 'make_service_test';
  static const String makeWidgetTest = 'make_widget_test';
}

class MethodCreatedVariableNames {
  MethodCreatedVariableNames._();

  static const String name = 'name';
  static const String type = 'type';
}
