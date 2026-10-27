import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class KpiStripWidget extends StatelessWidget {
  final int totalWeeks;
  final int totalLessons;
  final int totalSchedule;

  const KpiStripWidget({
    required this.totalWeeks,
    required this.totalLessons,
    required this.totalSchedule,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: _KpiCell(
            iconName: 'calendar_today_outlined',
            label: 'My Weeks',
            value: totalWeeks,
            bgColor: AppTheme.primaryContainer,
            iconColor: AppTheme.primary,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _KpiCell(
            iconName: 'menu_book_outlined',
            label: 'My Lessons',
            value: totalLessons,
            bgColor: const Color(0xFFF3F0FF),
            iconColor: AppTheme.vakAuditory,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _KpiCell(
            iconName: 'event_note_outlined',
            label: 'Class Schedule',
            value: totalSchedule,
            bgColor: const Color(0xFFFFF8E7),
            iconColor: const Color(0xFFE17055),
          ),
        ),
      ],
    );
  }
}

class _KpiCell extends StatelessWidget {
  final String iconName;
  final String label;
  final int value;
  final Color bgColor;
  final Color iconColor;

  const _KpiCell({
    required this.iconName,
    required this.label,
    required this.value,
    required this.bgColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: iconColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: iconName,
                    color: iconColor,
                    size: 16,
                  ),
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: 'arrow_outward',
                    color: iconColor,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '$value',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: const Color(0xFF1A1A2E),
              fontWeight: FontWeight.w700,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          Text(
            'Total',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: iconColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
