import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../planner_screen.dart';

class WeekPlanCardWidget extends StatefulWidget {
  final WeekPlan weekPlan;

  const WeekPlanCardWidget({required this.weekPlan, super.key});

  @override
  State<WeekPlanCardWidget> createState() => _WeekPlanCardWidgetState();
}

class _WeekPlanCardWidgetState extends State<WeekPlanCardWidget>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _expandController;
  late Animation<double> _expandAnim;

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnim = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _expandController.forward();
      } else {
        _expandController.reverse();
      }
    });
  }

  Color _examColor() {
    switch (widget.weekPlan.examType) {
      case ExamType.unitTest:
        return AppTheme.secondary;
      case ExamType.halfYearly:
        return AppTheme.warning;
      case ExamType.finalExam:
        return AppTheme.error;
      default:
        return Colors.transparent;
    }
  }

  String _examLabel() {
    switch (widget.weekPlan.examType) {
      case ExamType.unitTest:
        return 'Unit Test';
      case ExamType.halfYearly:
        return 'Half-Yearly';
      case ExamType.finalExam:
        return 'Final Exam';
      default:
        return '';
    }
  }

  Color _cardBorderColor() {
    if (widget.weekPlan.examType != ExamType.none) {
      return _examColor().withAlpha(102);
    }
    if (widget.weekPlan.hasHoliday) return AppTheme.secondary.withAlpha(77);
    return const Color(0xFFEDE9FF);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = widget.weekPlan.lessonsPlanned > 0
        ? widget.weekPlan.lessonsCompleted / widget.weekPlan.lessonsPlanned
        : 0.0;
    final isExamWeek = widget.weekPlan.examType != ExamType.none;

    return GestureDetector(
      onTap: _toggleExpand,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _cardBorderColor(),
            width: isExamWeek ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isExamWeek
                              ? _examColor().withAlpha(38)
                              : AppTheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'W${widget.weekPlan.weekNumber}',
                            style: TextStyle(
                              color: isExamWeek
                                  ? _examColor()
                                  : AppTheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.weekPlan.dateRange,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              widget.weekPlan.topics,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFF1A1A2E),
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                              ),
                              maxLines: _expanded ? null : 2,
                              overflow: _expanded
                                  ? TextOverflow.visible
                                  : TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      AnimatedRotation(
                        turns: _expanded ? 0.5 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: CustomIconWidget(
                          iconName: 'keyboard_arrow_down',
                          color: theme.colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _metaChip(
                        iconName: 'menu_book_outlined',
                        label: '${widget.weekPlan.lessonsPlanned} lessons',
                        color: AppTheme.primary,
                        bg: AppTheme.primaryContainer,
                      ),
                      const SizedBox(width: 6),
                      if (isExamWeek)
                        _metaChip(
                          iconName: 'assignment_outlined',
                          label: _examLabel(),
                          color: _examColor(),
                          bg: _examColor().withAlpha(31),
                        ),
                      if (widget.weekPlan.hasHoliday) ...[
                        const SizedBox(width: 6),
                        _metaChip(
                          iconName: 'event_busy_outlined',
                          label: 'Holiday',
                          color: AppTheme.success,
                          bg: AppTheme.successContainer,
                        ),
                      ],
                      const Spacer(),
                      Text(
                        '${(progress * 100).round()}%',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: progress > 0
                              ? AppTheme.primary
                              : theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: const Color(0xFFEDE9FF),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isExamWeek ? _examColor() : AppTheme.primary,
                      ),
                      minHeight: 5,
                    ),
                  ),
                ],
              ),
            ),
            SizeTransition(
              sizeFactor: _expandAnim,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: const Color(0xFFEDE9FF),
                      margin: const EdgeInsets.only(bottom: 12),
                    ),
                    if (widget.weekPlan.hasHoliday) ...[
                      _detailRow(
                        iconName: 'event_busy_outlined',
                        color: AppTheme.success,
                        title: 'Holiday This Week',
                        content: widget.weekPlan.holidayName,
                      ),
                      const SizedBox(height: 10),
                    ],
                    _detailRow(
                      iconName: 'psychology_outlined',
                      color: AppTheme.primary,
                      title: 'VAK Teaching Strategy',
                      content: widget.weekPlan.vakStrategy,
                    ),
                    const SizedBox(height: 10),
                    _detailRow(
                      iconName: 'check_circle_outlined',
                      color: AppTheme.success,
                      title: 'Lesson Progress',
                      content:
                          '${widget.weekPlan.lessonsCompleted} of ${widget.weekPlan.lessonsPlanned} lessons completed',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _metaChip({
    required String iconName,
    required String label,
    required Color color,
    required Color bg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(iconName: iconName, color: color, size: 11),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow({
    required String iconName,
    required Color color,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withAlpha(31),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: CustomIconWidget(iconName: iconName, color: color, size: 16),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1A1A2E),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                content,
                style: const TextStyle(
                  color: Color(0xFF4A4560),
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
