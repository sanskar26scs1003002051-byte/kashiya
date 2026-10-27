import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/status_badge_widget.dart';
import '../dashboard_screen.dart';

class ClassCardWidget extends StatelessWidget {
  final ClassModel classModel;
  final VoidCallback onTap;

  const ClassCardWidget({
    required this.classModel,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vakCompletion = classModel.totalStudents > 0
        ? (classModel.testedStudents / classModel.totalStudents * 100).round()
        : 0;
    final isUrgent = classModel.weeksToExam <= 3;
    final allTested =
        classModel.testedStudents == classModel.totalStudents &&
        classModel.totalStudents > 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: classModel.accentColor,
          borderRadius: BorderRadius.circular(20),
          border: isUrgent
              ? Border.all(color: AppTheme.warning.withAlpha(102), width: 1.5)
              : null,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: _subjectIcon(classModel.subject),
                      color: AppTheme.primary,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        classModel.grade,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        classModel.name,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: const Color(0xFF1A1A2E),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                StatusBadgeWidget(
                  type: allTested
                      ? BadgeType.active
                      : classModel.testedStudents == 0
                      ? BadgeType.untested
                      : BadgeType.draft,
                  customLabel: allTested
                      ? 'VAK Done'
                      : classModel.testedStudents == 0
                      ? 'Untested'
                      : '$vakCompletion% Done',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              classModel.subject,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF1A1A2E),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            if (allTested)
              _buildVakBar(classModel)
            else
              _buildProgressBar(vakCompletion, theme),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildAvatarStack(),
                const SizedBox(width: 6),
                Text(
                  '${classModel.totalStudents} students',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isUrgent
                        ? AppTheme.warning.withAlpha(38)
                        : Colors.white.withAlpha(179),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'event_outlined',
                        color: isUrgent
                            ? AppTheme.warning
                            : theme.colorScheme.onSurfaceVariant,
                        size: 11,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${classModel.weeksToExam}w to ${classModel.nextExam}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: isUrgent
                              ? AppTheme.warning
                              : theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
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
          ],
        ),
      ),
    );
  }

  Widget _buildVakBar(ClassModel c) {
    final total = c.visualCount + c.auditoryCount + c.kinestheticCount;
    if (total == 0) return const SizedBox.shrink();
    final vPct = c.visualCount / total;
    final aPct = c.auditoryCount / total;
    final kPct = c.kinestheticCount / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Row(
            children: [
              Expanded(
                flex: (vPct * 100).round(),
                child: Container(height: 6, color: AppTheme.vakVisual),
              ),
              Expanded(
                flex: (aPct * 100).round(),
                child: Container(height: 6, color: AppTheme.vakAuditory),
              ),
              Expanded(
                flex: (kPct * 100).round(),
                child: Container(height: 6, color: AppTheme.vakKinesthetic),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _vakLegend('V', c.visualCount, AppTheme.vakVisual),
            const SizedBox(width: 8),
            _vakLegend('A', c.auditoryCount, AppTheme.vakAuditory),
            const SizedBox(width: 8),
            _vakLegend('K', c.kinestheticCount, AppTheme.vakKinesthetic),
          ],
        ),
      ],
    );
  }

  Widget _vakLegend(String label, int count, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 3),
        Text(
          '$label: $count',
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4A4560),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(int percent, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'VAK Progress',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              '$percent%',
              style: theme.textTheme.labelSmall?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percent / 100,
            backgroundColor: Colors.white.withAlpha(153),
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primary),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarStack() {
    final colors = [
      const Color(0xFF74B9FF),
      const Color(0xFFA29BFE),
      const Color(0xFF55EFC4),
    ];
    return SizedBox(
      width: 48,
      height: 22,
      child: Stack(
        children: List.generate(3, (i) {
          return Positioned(
            left: i * 14.0,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: colors[i],
                shape: BoxShape.circle,
                border: const Border.fromBorderSide(
                  BorderSide(color: Colors.white, width: 1.5),
                ),
              ),
              child: Center(
                child: Text(
                  ['A', 'B', 'C'][i],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  String _subjectIcon(String subject) {
    if (subject.toLowerCase().contains('math')) return 'calculate_outlined';
    if (subject.toLowerCase().contains('physics')) return 'science_outlined';
    if (subject.toLowerCase().contains('chemistry')) return 'biotech_outlined';
    if (subject.toLowerCase().contains('english')) return 'menu_book_outlined';
    if (subject.toLowerCase().contains('history')) {
      return 'history_edu_outlined';
    }
    return 'school_outlined';
  }
}
