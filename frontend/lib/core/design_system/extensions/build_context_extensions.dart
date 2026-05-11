import 'package:flutter/material.dart';

/// Convenient extensions on [BuildContext] for accessing theme and media.
extension BuildContextExtensions on BuildContext {
  /// Shorthand for [Theme.of].
  ThemeData get theme => Theme.of(this);

  /// Shorthand for [Theme.of().textTheme].
  TextTheme get textTheme => theme.textTheme;

  /// Shorthand for [Theme.of().colorScheme].
  ColorScheme get colorScheme => theme.colorScheme;

  /// Shorthand for [MediaQuery.sizeOf].
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Shorthand for screen width.
  double get screenWidth => screenSize.width;

  /// Shorthand for screen height.
  double get screenHeight => screenSize.height;

  /// Shows a [SnackBar] with the given [message].
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? colorScheme.error : null,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
