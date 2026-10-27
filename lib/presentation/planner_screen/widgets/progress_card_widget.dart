import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class ProgressCardWidget extends StatelessWidget {
  final double progress;
  final int completedLessons;
  final int totalLessons;

  const ProgressCardWidget({
    required this.progress,
    required this.completedLessons,
    required this.totalLessons,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pct = (progress * 100).round();
    final isOnTrack = progress >= 0.5;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: 'donut_large',
                    color: AppTheme.primary,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Average Progress',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: const Color(0xFF1A1A2E),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '$completedLessons of $totalLessons lessons taught',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isOnTrack
                      ? AppTheme.successContainer
                      : const Color(0xFFFFEBE6),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: 'arrow_outward',
                    color: isOnTrack ? AppTheme.success : AppTheme.warning,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '$pct%',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: const Color(0xFF1A1A2E),
                  fontWeight: FontWeight.w700,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFEDE9FF),
              valueColor: AlwaysStoppedAnimation<Color>(
                isOnTrack ? AppTheme.primary : AppTheme.warning,
              ),
              minHeight: 10,
            ),
          ),
        ],
      ),
    );
  }
}
