import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart' as yaml;

String getPackageName() {
  final current = Directory.current;
  final pubspecYamlFile = File(
    path.join(current.absolute.path, 'pubspec.yaml'),
  );

  var packageName = path.basename(current.absolute.path);

  if (pubspecYamlFile.existsSync()) {
    try {
      final pubspecYaml = pubspecYamlFile.readAsStringSync();
      final pubspecYamlDoc = yaml.loadYaml(pubspecYaml);
      // ignore: avoid_dynamic_calls
      packageName = pubspecYamlDoc['name'] as String;
    } catch (_) {
      // do nothing
    }
  }
  return packageName;
}
