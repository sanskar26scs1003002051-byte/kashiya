import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../core/app_export.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/status_badge_widget.dart';
import 'widgets/kpi_strip_widget.dart';
import 'widgets/progress_card_widget.dart';
import 'widgets/weekly_chart_widget.dart';
import 'widgets/monthly_progress_widget.dart';
import 'widgets/week_plan_card_widget.dart';

enum ExamType { unitTest, halfYearly, finalExam, none }

class WeekPlan {
  final int weekNumber;
  final String dateRange;
  final String topics;
  final int lessonsPlanned;
  final int lessonsCompleted;
  final ExamType examType;
  final bool hasHoliday;
  final String holidayName;
  final String vakStrategy;
  final bool isSundaySkipped;

  const WeekPlan({
    required this.weekNumber,
    required this.dateRange,
    required this.topics,
    required this.lessonsPlanned,
    required this.lessonsCompleted,
    required this.examType,
    required this.hasHoliday,
    required this.holidayName,
    required this.vakStrategy,
    required this.isSundaySkipped,
  });

  factory WeekPlan.fromMap(Map<String, dynamic> map) {
    return WeekPlan(
      weekNumber: map['weekNumber'] as int,
      dateRange: map['dateRange'] as String,
      topics: map['topics'] as String,
      lessonsPlanned: map['lessonsPlanned'] as int,
      lessonsCompleted: map['lessonsCompleted'] as int,
      examType: _examFromString(map['examType'] as String),
      hasHoliday: map['hasHoliday'] as bool,
      holidayName: map['holidayName'] as String,
      vakStrategy: map['vakStrategy'] as String,
      isSundaySkipped: map['isSundaySkipped'] as bool,
    );
  }

  static ExamType _examFromString(String v) {
    switch (v) {
      case 'unitTest':
        return ExamType.unitTest;
      case 'halfYearly':
        return ExamType.halfYearly;
      case 'finalExam':
        return ExamType.finalExam;
      default:
        return ExamType.none;
    }
  }
}

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  // TODO: Replace with Riverpod/Bloc for production
  int _selectedClassIndex = 0;
  int _selectedMonthIndex = 0;
  late List<WeekPlan> _weekPlans;

  final List<String> _classNames = [
    'Grade 9-A — Mathematics',
    'Grade 10-B — Physics',
    'Grade 11-C — Chemistry',
    'Grade 8-D — English Lit',
  ];

  final List<String> _months = [
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
    'January',
    'February',
    'March',
    'April',
  ];

  final List<Map<String, dynamic>> _weekPlanMaps = [
    {
      'weekNumber': 1,
      'dateRange': '7–11 Jul 2025',
      'topics':
          'Number Systems: Real Numbers, Irrational Numbers, Decimal Expansions',
      'lessonsPlanned': 5,
      'lessonsCompleted': 5,
      'examType': 'none',
      'hasHoliday': false,
      'holidayName': '',
      'vakStrategy':
          'Visual: Number line diagrams. Auditory: Group discussion on irrational vs rational. Kinesthetic: Plotting on physical number lines.',
      'isSundaySkipped': true,
    },
    {
      'weekNumber': 2,
      'dateRange': '14–18 Jul 2025',
      'topics': 'Polynomials: Zeroes, Remainder Theorem, Factorisation',
      'lessonsPlanned': 5,
      'lessonsCompleted': 5,
      'examType': 'none',
      'hasHoliday': false,
      'holidayName': '',
      'vakStrategy':
          'Visual: Factor tree charts. Auditory: Verbal explanation of theorem. Kinesthetic: Algebra tile manipulation.',
      'isSundaySkipped': true,
    },
    {
      'weekNumber': 3,
      'dateRange': '21–25 Jul 2025',
      'topics': 'Linear Equations in Two Variables: Graphical solutions',
      'lessonsPlanned': 4,
      'lessonsCompleted': 3,
      'examType': 'none',
      'hasHoliday': true,
      'holidayName': 'Muharram (23 Jul)',
      'vakStrategy':
          'Visual: Coordinate graph plotting. Auditory: Narrate solution steps aloud. Kinesthetic: Pair graphing activity.',
      'isSundaySkipped': true,
    },
    {
      'weekNumber': 4,
      'dateRange': '28 Jul – 1 Aug 2025',
      'topics': 'Unit Test I — Number Systems & Polynomials',
      'lessonsPlanned': 3,
      'lessonsCompleted': 2,
      'examType': 'unitTest',
      'hasHoliday': false,
      'holidayName': '',
      'vakStrategy':
          'Revision: Visual — mind maps. Auditory — oral Q&A. Kinesthetic — practice papers.',
      'isSundaySkipped': true,
    },
    {
      'weekNumber': 5,
      'dateRange': '4–8 Aug 2025',
      'topics': 'Triangles: Congruence, Similarity, Pythagoras Theorem',
      'lessonsPlanned': 5,
      'lessonsCompleted': 4,
      'examType': 'none',
      'hasHoliday': false,
      'holidayName': '',
      'vakStrategy':
          'Visual: Geometry diagrams and proofs. Auditory: Theorem chanting. Kinesthetic: Compass and ruler constructions.',
      'isSundaySkipped': true,
    },
    {
      'weekNumber': 6,
      'dateRange': '11–15 Aug 2025',
      'topics': 'Quadrilaterals: Properties, Proofs, Mid-point Theorem',
      'lessonsPlanned': 4,
      'lessonsCompleted': 2,
      'examType': 'none',
      'hasHoliday': true,
      'holidayName': 'Independence Day (15 Aug)',
      'vakStrategy':
          'Visual: Shape property charts. Auditory: Peer teaching pairs. Kinesthetic: Folding paper shapes.',
      'isSundaySkipped': true,
    },
    {
      'weekNumber': 7,
      'dateRange': '18–22 Aug 2025',
      'topics': 'Areas of Parallelograms and Triangles',
      'lessonsPlanned': 5,
      'lessonsCompleted': 0,
      'examType': 'none',
      'hasHoliday': false,
      'holidayName': '',
      'vakStrategy':
          'Visual: Area formula cards. Auditory: Formula recitation. Kinesthetic: Grid paper area calculation.',
      'isSundaySkipped': true,
    },
    {
      'weekNumber': 8,
      'dateRange': '25–29 Aug 2025',
      'topics': 'Circles: Chords, Angles, Cyclic Quadrilaterals',
      'lessonsPlanned': 5,
      'lessonsCompleted': 0,
      'examType': 'none',
      'hasHoliday': false,
      'holidayName': '',
      'vakStrategy':
          'Visual: Circle theorem diagrams. Auditory: Theorem discussion. Kinesthetic: Compass circle drawing.',
      'isSundaySkipped': true,
    },
    {
      'weekNumber': 9,
      'dateRange': '1–5 Sep 2025',
      'topics': 'Surface Areas and Volumes: Cuboid, Cylinder, Cone, Sphere',
      'lessonsPlanned': 5,
      'lessonsCompleted': 0,
      'examType': 'none',
      'hasHoliday': false,
      'holidayName': '',
      'vakStrategy':
          'Visual: 3D net diagrams. Auditory: Formula derivation narration. Kinesthetic: Build 3D models.',
      'isSundaySkipped': true,
    },
    {
      'weekNumber': 10,
      'dateRange': '8–12 Sep 2025',
      'topics': 'Half-Yearly Exam — Chapters 1–8',
      'lessonsPlanned': 2,
      'lessonsCompleted': 0,
      'examType': 'halfYearly',
      'hasHoliday': false,
      'holidayName': '',
      'vakStrategy':
          'Full revision: Visual mind maps, Auditory oral tests, Kinesthetic past paper practice.',
      'isSundaySkipped': true,
    },
    {
      'weekNumber': 11,
      'dateRange': '15–19 Sep 2025',
      'topics': 'Statistics: Mean, Median, Mode, Frequency Distribution',
      'lessonsPlanned': 5,
      'lessonsCompleted': 0,
      'examType': 'none',
      'hasHoliday': false,
      'holidayName': '',
      'vakStrategy':
          'Visual: Frequency histograms. Auditory: Data storytelling. Kinesthetic: Class survey and analysis.',
      'isSundaySkipped': true,
    },
    {
      'weekNumber': 12,
      'dateRange': '22–26 Sep 2025',
      'topics': 'Probability: Experiments, Events, Empirical Probability',
      'lessonsPlanned': 5,
      'lessonsCompleted': 0,
      'examType': 'none',
      'hasHoliday': false,
      'holidayName': '',
      'vakStrategy':
          'Visual: Tree diagrams. Auditory: Probability discussions. Kinesthetic: Coin/dice experiments.',
      'isSundaySkipped': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _weekPlans = _weekPlanMaps.map(WeekPlan.fromMap).toList();
  }

  int get _totalLessonsPlanned =>
      _weekPlans.fold(0, (s, w) => s + w.lessonsPlanned);
  int get _totalLessonsCompleted =>
      _weekPlans.fold(0, (s, w) => s + w.lessonsCompleted);
  int get _totalHolidayWeeks => _weekPlans.where((w) => w.hasHoliday).length;
  double get _overallProgress => _totalLessonsPlanned > 0
      ? _totalLessonsCompleted / _totalLessonsPlanned
      : 0;

  List<WeekPlan> get _filteredWeeks {
    // For demo: show all weeks, grouped by month index
    return _weekPlans;
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FF),
      body: SafeArea(
        bottom: false,
        child: isTablet ? _buildTabletLayout() : _buildPhoneLayout(),
      ),
    );
  }

  Widget _buildPhoneLayout() {
    return CustomScrollView(
      slivers: [
        // AppBar
        SliverToBoxAdapter(child: _buildHeader()),
        // Class selector
        SliverToBoxAdapter(child: _buildClassSelector()),
        // KPI strip
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: KpiStripWidget(
              totalWeeks: _weekPlans.length,
              totalLessons: _totalLessonsPlanned,
              totalSchedule: _weekPlans
                  .where((w) => w.examType != ExamType.none)
                  .length,
            ),
          ),
        ),
        // Progress card
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: ProgressCardWidget(
              progress: _overallProgress,
              completedLessons: _totalLessonsCompleted,
              totalLessons: _totalLessonsPlanned,
            ),
          ),
        ),
        // Monthly progress chart
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: MonthlyProgressWidget(weekPlans: _weekPlans),
          ),
        ),
        // Weekly bar chart
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: WeeklyChartWidget(weekPlans: _weekPlans),
          ),
        ),
        // Month selector chips
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Weekly Breakdown',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF1A1A2E),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(right: 20),
                    itemCount: _months.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final isSelected = i == _selectedMonthIndex;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedMonthIndex = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.primary : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? AppTheme.primary
                                  : const Color(0xFFD0CCF0),
                            ),
                          ),
                          child: Text(
                            _months[i],
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF4A4560),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // Week plan list
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: WeekPlanCardWidget(weekPlan: _filteredWeeks[index]),
            );
          }, childCount: _filteredWeeks.length),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader()),
              SliverToBoxAdapter(child: _buildClassSelector()),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child: KpiStripWidget(
                    totalWeeks: _weekPlans.length,
                    totalLessons: _totalLessonsPlanned,
                    totalSchedule: _weekPlans
                        .where((w) => w.examType != ExamType.none)
                        .length,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                  child: WeeklyChartWidget(weekPlans: _weekPlans),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
                  child: Text(
                    'Weekly Breakdown',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                    child: WeekPlanCardWidget(weekPlan: _filteredWeeks[index]),
                  ),
                  childCount: _filteredWeeks.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
        Container(width: 1, color: const Color(0xFFEDE9FF)),
        SizedBox(
          width: 320,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 16),
                ProgressCardWidget(
                  progress: _overallProgress,
                  completedLessons: _totalLessonsCompleted,
                  totalLessons: _totalLessonsPlanned,
                ),
                const SizedBox(height: 12),
                MonthlyProgressWidget(weekPlans: _weekPlans),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go(AppRoutes.dashboardScreen),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'arrow_back_rounded',
                  color: const Color(0xFF1A1A2E),
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Session Planner',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: const Color(0xFF1A1A2E),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconWidget(
                  iconName: 'auto_awesome',
                  color: AppTheme.primary,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  'AI Generated',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassSelector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD0CCF0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: _selectedClassIndex,
            isExpanded: true,
            items: _classNames.asMap().entries.map((e) {
              return DropdownMenuItem(
                value: e.key,
                child: Text(
                  e.value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }).toList(),
            onChanged: (v) => setState(() => _selectedClassIndex = v!),
            icon: CustomIconWidget(
              iconName: 'expand_more',
              color: AppTheme.primary,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
