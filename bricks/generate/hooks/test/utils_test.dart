import 'package:test/test.dart';

import '../path_utils.dart';

void main() {
  group('path_utils', () {
    test('param names from path', () {
      List<String> getPathParams(String path) {
        final paths = <String>[];
        patternToRegExp(path, paths);
        return paths;
      }

      expect(getPathParams('/'), isEmpty);
      expect(getPathParams('/home'), isEmpty);
      expect(getPathParams('/home/:world'), contains('world'));
    });

    test('generates path from param keys', () {
      expect(
        createGeneratedPath('/hello/:foo/world/:bar'),
        equals(r'/hello/${params.foo}/world/${params.bar}'),
      );
    });
  });
}
