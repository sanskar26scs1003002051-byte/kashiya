import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../vak_test_screen.dart';

class VAKResultsWidget extends StatefulWidget {
  final StudentModel student;
  final VoidCallback onClose;

  const VAKResultsWidget({
    required this.student,
    required this.onClose,
    super.key,
  });

  @override
  State<VAKResultsWidget> createState() => _VAKResultsWidgetState();
}

class _VAKResultsWidgetState extends State<VAKResultsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _dominantLabel() {
    switch (widget.student.vakType) {
      case VAKType.visual:
        return 'Visual Learner';
      case VAKType.auditory:
        return 'Auditory Learner';
      case VAKType.kinesthetic:
        return 'Kinesthetic Learner';
      default:
        return 'Not Tested';
    }
  }

  Color _dominantColor() {
    switch (widget.student.vakType) {
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

  String _teachingTip() {
    switch (widget.student.vakType) {
      case VAKType.visual:
        return 'Use diagrams, mind maps, colour-coded notes, and visual aids. Seat near the board. Provide written instructions.';
      case VAKType.auditory:
        return 'Encourage verbal discussion, group work, and oral summaries. Use mnemonics and rhythmic patterns for memorisation.';
      case VAKType.kinesthetic:
        return 'Incorporate hands-on activities, experiments, and movement breaks. Allow note-taking during lessons.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total =
        widget.student.visualScore +
        widget.student.auditoryScore +
        widget.student.kinestheticScore;
    final dominantColor = _dominantColor();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: widget.onClose,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(15),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: 'close',
                      color: const Color(0xFF1A1A2E),
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'VAK Result',
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: const Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ScaleTransition(
            scale: _scaleAnim,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: dominantColor.withAlpha(26),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: dominantColor.withAlpha(77),
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  ClipOval(
                    child: CustomImageWidget(
                      imageUrl: widget.student.avatarUrl,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      semanticLabel: widget.student.semanticLabel,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.student.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF1A1A2E),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: dominantColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _dominantLabel(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
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
                Text(
                  'Score Breakdown',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 180,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: widget.student.visualScore.toDouble(),
                          color: AppTheme.vakVisual,
                          title: 'V\n${widget.student.visualScore}',
                          radius: 70,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        PieChartSectionData(
                          value: widget.student.auditoryScore.toDouble(),
                          color: AppTheme.vakAuditory,
                          title: 'A\n${widget.student.auditoryScore}',
                          radius: 70,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        PieChartSectionData(
                          value: widget.student.kinestheticScore.toDouble(),
                          color: AppTheme.vakKinesthetic,
                          title: 'K\n${widget.student.kinestheticScore}',
                          radius: 70,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                      sectionsSpace: 3,
                      centerSpaceRadius: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _legendItem(
                      'Visual',
                      widget.student.visualScore,
                      total,
                      AppTheme.vakVisual,
                    ),
                    _legendItem(
                      'Auditory',
                      widget.student.auditoryScore,
                      total,
                      AppTheme.vakAuditory,
                    ),
                    _legendItem(
                      'Kinesthetic',
                      widget.student.kinestheticScore,
                      total,
                      AppTheme.vakKinesthetic,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: dominantColor.withAlpha(20),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: dominantColor.withAlpha(64)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'lightbulb_outlined',
                      color: dominantColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Teaching Strategy',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: const Color(0xFF1A1A2E),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  _teachingTip(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: widget.onClose,
              style: FilledButton.styleFrom(
                backgroundColor: dominantColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Save & Return to Class',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _legendItem(String label, int score, int total, Color color) {
    final pct = total > 0 ? (score / total * 100).round() : 0;
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4A4560),
          ),
        ),
        Text(
          '$pct%',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}
