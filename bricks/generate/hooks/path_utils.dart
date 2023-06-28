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
