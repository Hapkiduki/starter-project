import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'package:flutter/widget_previews.dart';

/// Centered loading indicator used across the app.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppColors.primary),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Preview of loading indicator.
@Preview(name: 'Loading Indicator')
Widget previewLoadingIndicator() {
  return const Material(
    color: AppColors.background,
    child: LoadingIndicator(message: 'Loading articles...'),
  );
}
