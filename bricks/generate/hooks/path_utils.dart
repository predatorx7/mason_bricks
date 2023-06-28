// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// COPIED FROM PACKAGE:GO_ROUTER

final RegExp _parameterRegExp = RegExp(r':(\w+)(\((?:\\.|[^\\()])+\))?');

/// Converts a [pattern] such as `/user/:id` into [RegExp].
///
/// The path parameters can be specified by prefixing them with `:`. The
/// `parameters` are used for storing path parameter names.
///
///
/// For example:
///
///  `pattern` = `/user/:id/book/:bookId`
///
///  The `parameters` would contain `['id', 'bookId']` as a result of calling
///  this method.
RegExp patternToRegExp(String pattern, List<String> parameters) {
  final buffer = StringBuffer('^');
  var start = 0;
  for (final match in _parameterRegExp.allMatches(pattern)) {
    if (match.start > start) {
      buffer.write(RegExp.escape(pattern.substring(start, match.start)));
    }
    final name = match[1]!;
    final optionalPattern = match[2];
    final regex = optionalPattern != null
        ? _escapeGroup(optionalPattern, name)
        : '(?<$name>[^/]+)';
    buffer.write(regex);
    parameters.add(name);
    start = match.end;
  }

  if (start < pattern.length) {
    buffer.write(RegExp.escape(pattern.substring(start)));
  }

  if (!pattern.endsWith('/')) {
    buffer.write(r'(?=/|$)');
  }
  return RegExp(buffer.toString(), caseSensitive: false);
}

String _escapeGroup(String group, [String? name]) {
  final escapedGroup = group.replaceFirstMapped(
    RegExp('[:=!]'),
    (Match match) => '\\${match[0]}',
  );
  if (name != null) {
    return '(?<$name>$escapedGroup)';
  }
  return escapedGroup;
}

/// Reconstructs the full path from a [pattern] and path parameters.
///
/// This is useful for restoring the original path from a [RegExpMatch].
String patternToPath(String pattern, Map<String, String> pathParameters) {
  final buffer = StringBuffer();
  var start = 0;
  for (final match in _parameterRegExp.allMatches(pattern)) {
    if (match.start > start) {
      buffer.write(pattern.substring(start, match.start));
    }
    final name = match[1]!;
    buffer.write(pathParameters[name]);
    start = match.end;
  }

  if (start < pattern.length) {
    buffer.write(pattern.substring(start));
  }
  return buffer.toString();
}

String createGeneratedPath(String pattern) {
  final pathParameters = <String>[];
  patternToRegExp(pattern, pathParameters);
  return patternToPath(
    pattern,
    {
      for (final param in pathParameters) param: '\${params.$param}',
    },
  );
}
