import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart' as yaml;

final kDebugMode = Platform.environment['kDebugMode'] == 'true';

String getPackageName([Directory? directory]) {
  final current = directory ?? Directory.current;
  final currentDirectoryAbsolutePath = current.absolute.path;
  final pubspecYamlFile = File(
    path.join(currentDirectoryAbsolutePath, 'pubspec.yaml'),
  );

  if (pubspecYamlFile.existsSync()) {
    try {
      final pubspecYaml = pubspecYamlFile.readAsStringSync();
      final pubspecYamlDoc = yaml.loadYaml(pubspecYaml);
      // ignore: avoid_dynamic_calls
      return pubspecYamlDoc['name'] as String;
    } catch (_) {
      // do nothing
    }
  }
  return path.basename(currentDirectoryAbsolutePath);
}
