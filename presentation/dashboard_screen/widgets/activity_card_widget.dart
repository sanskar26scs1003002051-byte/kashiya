import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ActivityCardWidget extends StatelessWidget {
  final String iconName;
  final String title;
  final String metricValue;
  final String metricUnit;
  final Color bgColor;
  final Color iconBgColor;
  final VoidCallback? onTap;

  const ActivityCardWidget({
    required this.iconName,
    required this.title,
    required this.metricValue,
    required this.metricUnit,
    required this.bgColor,
    required this.iconBgColor,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Colored icon square
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: iconName,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: const Color(0xFF1A1A2E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        metricValue,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: const Color(0xFF1A1A2E),
                          fontWeight: FontWeight.w700,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        metricUnit,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Arrow circle
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'arrow_forward_rounded',
                  color: AppTheme.primary,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
