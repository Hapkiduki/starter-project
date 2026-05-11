import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'package:flutter/widget_previews.dart';

import '../extensions/build_context_extensions.dart';

/// Category label chip used across article cards and detail screens.
///
/// [filled] = true → red filled (e.g. EXCLUSIVE REPORT, COMMUNITY, FEATURED).
/// [filled] = false → outlined (e.g. LOCAL NEWS, POLITICS list tags).
class CategoryBadge extends StatelessWidget {
  const CategoryBadge(this.label, {super.key, this.filled = true});

  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: filled
          ? const BoxDecoration(color: AppColors.primary)
          : BoxDecoration(border: Border.all(color: AppColors.outline)),
      child: Text(
        label.toUpperCase(),
        style: context.textTheme.labelSmall?.copyWith(
          color: filled ? Colors.white : AppColors.textPrimary,
        ),
      ),
    );
  }
}

/// Preview of filled category badge.
@Preview(name: 'Filled Category Badge')
Widget previewCategoryBadgeFilled() {
  return const Material(
    color: AppColors.background,
    child: Padding(
      padding: EdgeInsets.all(16),
      child: CategoryBadge('Featured'),
    ),
  );
}

/// Preview of outlined category badge.
@Preview(name: 'Outlined Category Badge')
Widget previewCategoryBadgeOutlined() {
  return const Material(
    color: AppColors.background,
    child: Padding(
      padding: EdgeInsets.all(16),
      child: CategoryBadge('Local News', filled: false),
    ),
  );
}
