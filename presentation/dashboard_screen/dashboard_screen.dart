import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../core/app_export.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import 'widgets/dashboard_header_widget.dart';
import 'widgets/kpi_card_widget.dart';
import 'widgets/hero_banner_widget.dart';
import 'widgets/class_card_widget.dart';
import 'widgets/activity_card_widget.dart';

class ClassModel {
  final String id;
  final String name;
  final String subject;
  final int totalStudents;
  final int testedStudents;
  final int visualCount;
  final int auditoryCount;
  final int kinestheticCount;
  final String grade;
  final String nextExam;
  final int weeksToExam;
  final Color accentColor;
  final String imageUrl;
  final String semanticLabel;
  final String planStatus;

  const ClassModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.totalStudents,
    required this.testedStudents,
    required this.visualCount,
    required this.auditoryCount,
    required this.kinestheticCount,
    required this.grade,
    required this.nextExam,
    required this.weeksToExam,
    required this.accentColor,
    required this.imageUrl,
    required this.semanticLabel,
    required this.planStatus,
  });

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      id: map['id'] as String,
      name: map['name'] as String,
      subject: map['subject'] as String,
      totalStudents: map['totalStudents'] as int,
      testedStudents: map['testedStudents'] as int,
      visualCount: map['visualCount'] as int,
      auditoryCount: map['auditoryCount'] as int,
      kinestheticCount: map['kinestheticCount'] as int,
      grade: map['grade'] as String,
      nextExam: map['nextExam'] as String,
      weeksToExam: map['weeksToExam'] as int,
      accentColor: map['accentColor'] as Color,
      imageUrl: map['imageUrl'] as String,
      semanticLabel: map['semanticLabel'] as String,
      planStatus: map['planStatus'] as String,
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  // TODO: Replace with Riverpod/Bloc for production
  late AnimationController _entranceController;
  late List<Animation<double>> _itemAnimations;
  late List<ClassModel> _classes;

  final List<Map<String, dynamic>> _classMaps = [
    {
      'id': 'cls_001',
      'name': 'Grade 9-A',
      'subject': 'Mathematics',
      'totalStudents': 38,
      'testedStudents': 38,
      'visualCount': 16,
      'auditoryCount': 12,
      'kinestheticCount': 10,
      'grade': '9th Grade',
      'nextExam': 'Unit Test I',
      'weeksToExam': 3,
      'accentColor': const Color(0xFFE8F4FD),
      'imageUrl':
          'https://images.pexels.com/photos/3184360/pexels-photo-3184360.jpeg',
      'semanticLabel': 'Classroom of students studying mathematics at desks',
      'planStatus': 'active',
    },
    {
      'id': 'cls_002',
      'name': 'Grade 10-B',
      'subject': 'Physics',
      'totalStudents': 35,
      'testedStudents': 28,
      'visualCount': 14,
      'auditoryCount': 9,
      'kinestheticCount': 5,
      'grade': '10th Grade',
      'nextExam': 'Half-Yearly',
      'weeksToExam': 7,
      'accentColor': const Color(0xFFF3F0FF),
      'imageUrl':
          'https://images.pixabay.com/photo/2016/11/19/14/00/code-1839406_1280.jpg',
      'semanticLabel': 'Students in physics lab conducting experiments',
      'planStatus': 'draft',
    },
    {
      'id': 'cls_003',
      'name': 'Grade 11-C',
      'subject': 'Chemistry',
      'totalStudents': 32,
      'testedStudents': 0,
      'visualCount': 0,
      'auditoryCount': 0,
      'kinestheticCount': 0,
      'grade': '11th Grade',
      'nextExam': 'Unit Test I',
      'weeksToExam': 5,
      'accentColor': const Color(0xFFFFF8E7),
      'imageUrl':
          'https://images.pexels.com/photos/2280571/pexels-photo-2280571.jpeg',
      'semanticLabel':
          'Chemistry laboratory with students conducting experiments',
      'planStatus': 'draft',
    },
    {
      'id': 'cls_004',
      'name': 'Grade 8-D',
      'subject': 'English Literature',
      'totalStudents': 40,
      'testedStudents': 40,
      'visualCount': 18,
      'auditoryCount': 15,
      'kinestheticCount': 7,
      'grade': '8th Grade',
      'nextExam': 'Final Exam',
      'weeksToExam': 14,
      'accentColor': const Color(0xFFE8FDF5),
      'imageUrl':
          'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=400',
      'semanticLabel': 'Open books on a wooden table in a library setting',
      'planStatus': 'active',
    },
  ];

  @override
  void initState() {
    super.initState();
    _classes = _classMaps.map(ClassModel.fromMap).toList();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _itemAnimations = List.generate(6, (i) {
      final start = (i * 0.1).clamp(0.0, 0.7);
      return CurvedAnimation(
        parent: _entranceController,
        curve: Interval(
          start,
          (start + 0.4).clamp(0.0, 1.0),
          curve: Curves.easeOutCubic,
        ),
      );
    });
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(AppRoutes.vakTestScreen),
        icon: CustomIconWidget(
          iconName: 'add_rounded',
          color: Colors.white,
          size: 20,
        ),
        label: const Text('New VAK Test'),
        backgroundColor: AppTheme.primary,
      ),
    );
  }

  Widget _buildPhoneLayout() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: FadeTransition(
            opacity: _itemAnimations[0],
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.05),
                end: Offset.zero,
              ).animate(_itemAnimations[0]),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: const DashboardHeaderWidget(),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: FadeTransition(
            opacity: _itemAnimations[1],
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.05),
                end: Offset.zero,
              ).animate(_itemAnimations[1]),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: _buildKpiRow(),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: FadeTransition(
            opacity: _itemAnimations[2],
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.05),
                end: Offset.zero,
              ).animate(_itemAnimations[2]),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: const HeroBannerWidget(),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: FadeTransition(
            opacity: _itemAnimations[3],
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Classes',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF1A1A2E),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${_classes.length} classes',
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(color: AppTheme.primary),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final anim = index < _itemAnimations.length
                ? _itemAnimations[index.clamp(4, _itemAnimations.length - 1)]
                : _itemAnimations.last;
            return FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.06),
                  end: Offset.zero,
                ).animate(anim),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: ClassCardWidget(
                    classModel: _classes[index],
                    onTap: () => context.go(AppRoutes.plannerScreen),
                  ),
                ),
              ),
            );
          }, childCount: _classes.length),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child: const DashboardHeaderWidget(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                  child: const HeroBannerWidget(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                  child: Text(
                    'My Classes',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.6,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ClassCardWidget(
                      classModel: _classes[index],
                      onTap: () => context.go(AppRoutes.plannerScreen),
                    ),
                    childCount: _classes.length,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
        Container(
          width: 300,
          color: const Color(0xFFF8F7FF),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Overview',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                _buildKpiColumn(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKpiRow() {
    final totalStudents = _classes.fold(0, (sum, c) => sum + c.totalStudents);
    final testedStudents = _classes.fold(0, (sum, c) => sum + c.testedStudents);
    final urgentClass = _classes.reduce(
      (a, b) => a.weeksToExam < b.weeksToExam ? a : b,
    );

    return Row(
      children: [
        Expanded(
          child: KpiCardWidget(
            iconName: 'class_outlined',
            label: 'Classes',
            value: '${_classes.length}',
            subtitle: 'This session',
            accentColor: AppTheme.primary,
            bgColor: AppTheme.primaryContainer,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: KpiCardWidget(
            iconName: 'psychology_outlined',
            label: 'VAK Tested',
            value: '$testedStudents',
            subtitle: 'of $totalStudents students',
            accentColor: AppTheme.success,
            bgColor: const Color(0xFFE8FDF5),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: KpiCardWidget(
            iconName: 'event_outlined',
            label: 'Next Exam',
            value: '${urgentClass.weeksToExam}w',
            subtitle: urgentClass.nextExam,
            accentColor: urgentClass.weeksToExam <= 3
                ? AppTheme.warning
                : AppTheme.secondary,
            bgColor: urgentClass.weeksToExam <= 3
                ? const Color(0xFFFFEBE6)
                : const Color(0xFFFFF8E7),
          ),
        ),
      ],
    );
  }

  Widget _buildKpiColumn() {
    final totalStudents = _classes.fold(0, (sum, c) => sum + c.totalStudents);
    final testedStudents = _classes.fold(0, (sum, c) => sum + c.testedStudents);
    final urgentClass = _classes.reduce(
      (a, b) => a.weeksToExam < b.weeksToExam ? a : b,
    );

    return Column(
      children: [
        KpiCardWidget(
          iconName: 'class_outlined',
          label: 'Classes',
          value: '${_classes.length}',
          subtitle: 'This session',
          accentColor: AppTheme.primary,
          bgColor: AppTheme.primaryContainer,
        ),
        const SizedBox(height: 12),
        KpiCardWidget(
          iconName: 'psychology_outlined',
          label: 'VAK Tested',
          value: '$testedStudents',
          subtitle: 'of $totalStudents students',
          accentColor: AppTheme.success,
          bgColor: const Color(0xFFE8FDF5),
        ),
        const SizedBox(height: 12),
        KpiCardWidget(
          iconName: 'event_outlined',
          label: 'Next Exam',
          value: '${urgentClass.weeksToExam}w',
          subtitle: urgentClass.nextExam,
          accentColor: AppTheme.warning,
          bgColor: const Color(0xFFFFEBE6),
        ),
      ],
    );
  }
}
