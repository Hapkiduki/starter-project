import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../extensions/build_context_extensions.dart';
import '../previews/app_preview.dart';

/// Reusable error display widget with optional retry action.
class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({
    required this.message,
    super.key,
    this.onRetry,
    this.icon = Ionicons.alert_circle_outline,
  });

  final String message;
  final VoidCallback? onRetry;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: context.colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Ionicons.refresh_outline),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

@AppPreview(name: 'Error display with retry')
Widget errorDisplayWithRetryPreview() {
  return Material(
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: ErrorDisplay(
        message: 'Something went wrong. Please try again.',
        onRetry: () {}, // Replace with a callback to test the button
      ),
    ),
  );
}
