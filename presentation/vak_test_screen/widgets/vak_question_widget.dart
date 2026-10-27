import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../vak_test_screen.dart';

class VAKQuestionWidget extends StatelessWidget {
  final StudentModel student;
  final VAKQuestion question;
  final int questionIndex;
  final int totalQuestions;
  final int? selectedAnswer;
  final void Function(int) onAnswer;
  final VoidCallback? onBack;

  const VAKQuestionWidget({
    required this.student,
    required this.question,
    required this.questionIndex,
    required this.totalQuestions,
    required this.selectedAnswer,
    required this.onAnswer,
    this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = (questionIndex + 1) / totalQuestions;

    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Row(
            children: [
              if (onBack != null)
                GestureDetector(
                  onTap: onBack,
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
              if (onBack != null) const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VAK Assessment',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF1A1A2E),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      student.name,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${questionIndex + 1}/$totalQuestions',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w700,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
        // Progress bar
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFEDE9FF),
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primary),
              minHeight: 8,
            ),
          ),
        ),
        // Question card
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Question ${questionIndex + 1}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        question.question,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: const Color(0xFF1A1A2E),
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Choose the option that best describes you:',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                _buildOption(
                  context,
                  0,
                  question.visualOption,
                  AppTheme.vakVisual,
                  'visibility_outlined',
                  'Visual',
                ),
                const SizedBox(height: 10),
                _buildOption(
                  context,
                  1,
                  question.auditoryOption,
                  AppTheme.vakAuditory,
                  'hearing_outlined',
                  'Auditory',
                ),
                const SizedBox(height: 10),
                _buildOption(
                  context,
                  2,
                  question.kinestheticOption,
                  AppTheme.vakKinesthetic,
                  'sports_handball_outlined',
                  'Kinesthetic',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOption(
    BuildContext context,
    int index,
    String text,
    Color color,
    String icon,
    String label,
  ) {
    final isSelected = selectedAnswer == index;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onAnswer(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.12) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : const Color(0xFFEDE9FF),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? color.withOpacity(0.15)
                  : Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? color : color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: icon,
                  color: isSelected ? Colors.white : color,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: isSelected
                          ? color
                          : theme.colorScheme.onSurfaceVariant,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    text,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF1A1A2E),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Center(
                  child: CustomIconWidget(
                    iconName: 'check',
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
