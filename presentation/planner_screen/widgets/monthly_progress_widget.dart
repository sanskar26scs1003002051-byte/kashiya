import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../planner_screen.dart';

class _MonthData {
  final String month;
  final int lessons;
  final int maxLessons;
  final Color barColor;

  const _MonthData({
    required this.month,
    required this.lessons,
    required this.maxLessons,
    required this.barColor,
  });
}

class MonthlyProgressWidget extends StatelessWidget {
  final List<WeekPlan> weekPlans;

  const MonthlyProgressWidget({required this.weekPlans, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Aggregate by approximate month (every ~4 weeks = 1 month)
    final List<_MonthData> monthData = [
      _MonthData(
        month: 'Jul',
        lessons: 23,
        maxLessons: 44,
        barColor: AppTheme.vakAuditory,
      ),
      _MonthData(
        month: 'Aug',
        lessons: 44,
        maxLessons: 44,
        barColor: AppTheme.primary,
      ),
      _MonthData(
        month: 'Sep',
        lessons: 14,
        maxLessons: 44,
        barColor: AppTheme.vakKinesthetic,
      ),
    ];

    final int maxLessons = monthData
        .map((m) => m.lessons)
        .reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
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
              Text(
                'Monthly Overview',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: const Color(0xFF1A1A2E),
                  fontWeight: FontWeight.w700,
                ),
              ),
              CustomIconWidget(
                iconName: 'more_vert',
                color: theme.colorScheme.onSurfaceVariant,
                size: 18,
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 160,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: monthData.map((data) {
                final fillRatio = maxLessons > 0
                    ? data.lessons / maxLessons
                    : 0.0;
                return _CapsuleBar(
                  month: data.month,
                  lessons: data.lessons,
                  fillRatio: fillRatio,
                  barColor: data.barColor,
                  badge: data.lessons,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CapsuleBar extends StatefulWidget {
  final String month;
  final int lessons;
  final double fillRatio;
  final Color barColor;
  final int badge;

  const _CapsuleBar({
    required this.month,
    required this.lessons,
    required this.fillRatio,
    required this.barColor,
    required this.badge,
  });

  @override
  State<_CapsuleBar> createState() => _CapsuleBarState();
}

class _CapsuleBarState extends State<_CapsuleBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _heightAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const totalBarHeight = 120.0;
    const barWidth = 56.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Bar container
        SizedBox(
          width: barWidth,
          height: totalBarHeight,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Background track (full height capsule)
              Container(
                width: barWidth,
                height: totalBarHeight,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EEF8),
                  borderRadius: BorderRadius.circular(barWidth / 2),
                ),
              ),
              // Animated fill
              AnimatedBuilder(
                animation: _heightAnim,
                builder: (context, child) {
                  final fillHeight =
                      totalBarHeight * widget.fillRatio * _heightAnim.value;
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: barWidth,
                          height: fillHeight.clamp(barWidth, totalBarHeight),
                          decoration: BoxDecoration(
                            color: widget.barColor,
                            borderRadius: BorderRadius.circular(barWidth / 2),
                          ),
                        ),
                        // Badge at top of fill
                        if (fillHeight > 30)
                          Positioned(
                            top: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A2E),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${widget.badge}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '${widget.lessons}\nlessons',
          textAlign: TextAlign.center,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          widget.month,
          style: theme.textTheme.labelMedium?.copyWith(
            color: const Color(0xFF1A1A2E),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
