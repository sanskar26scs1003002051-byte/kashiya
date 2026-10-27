import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../planner_screen.dart';

class WeeklyChartWidget extends StatefulWidget {
  final List<WeekPlan> weekPlans;

  const WeeklyChartWidget({required this.weekPlans, super.key});

  @override
  State<WeeklyChartWidget> createState() => _WeeklyChartWidgetState();
}

class _WeeklyChartWidgetState extends State<WeeklyChartWidget> {
  int _touchedIndex = -1;

  Color _barColor(WeekPlan plan, bool isTouched) {
    if (plan.examType == ExamType.unitTest) return AppTheme.secondary;
    if (plan.examType == ExamType.halfYearly) return AppTheme.warning;
    if (plan.examType == ExamType.finalExam) return AppTheme.error;
    if (isTouched) return AppTheme.primary;
    return AppTheme.primaryContainer;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayWeeks = widget.weekPlans.take(7).toList();

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
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppTheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: 'bar_chart',
                    color: AppTheme.primary,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progress Learning',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: const Color(0xFF1A1A2E),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Lessons per week — current session',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
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
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 6,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipRoundedRadius: 10,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final week = displayWeeks[group.x.toInt()];
                      return BarTooltipItem(
                        '${rod.toY.toInt()} lessons\nWk ${week.weekNumber}',
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                  touchCallback: (event, response) {
                    setState(() {
                      _touchedIndex =
                          response?.spot?.touchedBarGroupIndex ?? -1;
                    });
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final i = value.toInt();
                        if (i >= displayWeeks.length)
                          return const SizedBox.shrink();
                        final week = displayWeeks[i];
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            'W${week.weekNumber}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _touchedIndex == i
                                  ? AppTheme.primary
                                  : theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        );
                      },
                      reservedSize: 28,
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 2,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: const Color(0xFFEDE9FF),
                    strokeWidth: 1,
                    dashArray: [4, 4],
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(displayWeeks.length, (i) {
                  final week = displayWeeks[i];
                  final isTouched = i == _touchedIndex;
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: week.lessonsPlanned.toDouble(),
                        color: _barColor(week, isTouched),
                        width: isTouched ? 26 : 22,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: 6,
                          color: const Color(0xFFF5F3FF),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendDot(AppTheme.primaryContainer, 'Regular'),
              const SizedBox(width: 12),
              _legendDot(AppTheme.secondary, 'Unit Test'),
              const SizedBox(width: 12),
              _legendDot(AppTheme.warning, 'Half-Yearly'),
              const SizedBox(width: 12),
              _legendDot(AppTheme.error, 'Final Exam'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4A4560),
          ),
        ),
      ],
    );
  }
}
