import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/status_badge_widget.dart';
import '../vak_test_screen.dart';

class StudentListWidget extends StatelessWidget {
  final List<StudentModel> students;
  final void Function(StudentModel) onStartTest;

  const StudentListWidget({
    required this.students,
    required this.onStartTest,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
      itemCount: students.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final student = students[index];
        final isTested = student.vakType != VAKType.untested;
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isTested
                  ? _vakColor(student.vakType).withOpacity(0.3)
                  : const Color(0xFFEDE9FF),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // Avatar
              Stack(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isTested
                            ? _vakColor(student.vakType)
                            : const Color(0xFFD0CCF0),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: CustomImageWidget(
                        imageUrl: student.avatarUrl,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        semanticLabel: student.semanticLabel,
                      ),
                    ),
                  ),
                  if (isTested)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: _vakColor(student.vakType),
                          shape: BoxShape.circle,
                          border: const Border.fromBorderSide(
                            BorderSide(color: Colors.white, width: 1.5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            student.vakType.name[0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              // Name + roll
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: const Color(0xFF1A1A2E),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Roll No. ${student.rollNumber}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (isTested) ...[
                      const SizedBox(height: 4),
                      _buildScoreBar(student),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Badge + action
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StatusBadgeWidget(
                    type: isTested
                        ? _badgeType(student.vakType)
                        : BadgeType.untested,
                    customLabel: isTested
                        ? student.vakType.name[0].toUpperCase() +
                              student.vakType.name.substring(1)
                        : 'Untested',
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () => onStartTest(student),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: isTested
                            ? const Color(0xFFF5F3FF)
                            : AppTheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isTested ? 'Re-test' : 'Start Test',
                        style: TextStyle(
                          color: isTested ? AppTheme.primary : Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScoreBar(StudentModel s) {
    final total = s.visualScore + s.auditoryScore + s.kinestheticScore;
    if (total == 0) return const SizedBox.shrink();
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Row(
        children: [
          Expanded(
            flex: s.visualScore,
            child: Container(height: 4, color: AppTheme.vakVisual),
          ),
          Expanded(
            flex: s.auditoryScore,
            child: Container(height: 4, color: AppTheme.vakAuditory),
          ),
          Expanded(
            flex: s.kinestheticScore,
            child: Container(height: 4, color: AppTheme.vakKinesthetic),
          ),
        ],
      ),
    );
  }

  Color _vakColor(VAKType type) {
    switch (type) {
      case VAKType.visual:
        return AppTheme.vakVisual;
      case VAKType.auditory:
        return AppTheme.vakAuditory;
      case VAKType.kinesthetic:
        return AppTheme.vakKinesthetic;
      default:
        return const Color(0xFFB2BEC3);
    }
  }

  BadgeType _badgeType(VAKType type) {
    switch (type) {
      case VAKType.visual:
        return BadgeType.visual;
      case VAKType.auditory:
        return BadgeType.auditory;
      case VAKType.kinesthetic:
        return BadgeType.kinesthetic;
      default:
        return BadgeType.untested;
    }
  }
}
