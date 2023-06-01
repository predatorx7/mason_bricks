import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'hello_world.dart';

// Examples can assume:
// late BuildContext context;

/// A [HelloWorldThemeData] that theme to [HelloWorld] with
/// [HelloWorldTheme.of].
@immutable
class HelloWorldThemeData with Diagnosticable {
  /// Creates an [HelloWorldThemeData].
  ///
  /// The properties [helloWorldProperty] may be null.
  const HelloWorldThemeData({
    this.helloWorldProperty,
  });

  /// Description for [helloWorld].
  final Object? helloWorldProperty;

  /// Creates a copy of this object but with the given fields replaced with the
  /// new values.
  HelloWorldThemeData copyWith({
    Object? helloWorldProperty,
  }) {
    return HelloWorldThemeData(
      helloWorldProperty: helloWorldProperty ?? this.helloWorldProperty,
    );
  }

  /// Linearly interpolate between two Hello world themes.
  static HelloWorldThemeData? lerp(
      HelloWorldThemeData? a, 
      HelloWorldThemeData? b, 
      double t,
    ) {
    if (a == null && b == null) {
      return null;
    }
    return HelloWorldThemeData(
      helloWorldProperty:
          t < 0.5 ? a?.helloWorldProperty : b?.helloWorldProperty,
    );
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      helloWorldProperty,
    ];
    return Object.hashAll(values);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is HelloWorldThemeData &&
        other.helloWorldProperty == helloWorldProperty;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Object?>(
      'helloWorldProperty',
      helloWorldProperty,
      defaultValue: null,
    ));
  }
}

/// An inherited widget that provides theme for [HelloWorld] in this
/// widget's subtree.
class HelloWorldTheme extends InheritedTheme {
  /// Creates a theme for [HelloWorld] in this widget's subtree.
  const HelloWorldTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Specifies the theme overrides for descendant [HelloWorld] widget.
  final HelloWorldThemeData data;

  /// The closest instance of this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// HelloWorldThemeData? theme = HelloWorldTheme.maybeOf(context);
  /// ```
  static HelloWorldThemeData? maybeOf(BuildContext context) {
    final HelloWorldTheme? helloWorldTheme =
        context.dependOnInheritedWidgetOfExactType<HelloWorldTheme>();
    return helloWorldTheme?.data;
  }

  /// The closest instance of this class that encloses the given context.
  ///
  /// If there is no enclosing [HelloWorldTheme] widget, then
  /// a default [HelloWorldThemeData] object is used.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// HelloWorldThemeData theme = HelloWorldTheme.of(context);
  /// ```
  static HelloWorldThemeData of(BuildContext context) {
    final HelloWorldTheme? helloWorldTheme =
        context.dependOnInheritedWidgetOfExactType<HelloWorldTheme>();
    return helloWorldTheme?.data ?? HelloWorldThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return HelloWorldTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(HelloWorldTheme oldWidget) => data != oldWidget.data;
}
