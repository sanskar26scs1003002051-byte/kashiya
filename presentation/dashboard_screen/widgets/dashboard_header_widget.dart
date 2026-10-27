import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class DashboardHeaderWidget extends StatelessWidget {
  const DashboardHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good Morning'
        : hour < 17
        ? 'Good Afternoon'
        : 'Good Evening';

    return Row(
      children: [
        // Avatar
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.primaryContainer, width: 2),
          ),
          child: ClipOval(
            child: CustomImageWidget(
              imageUrl:
                  'https://images.pexels.com/photos/5212317/pexels-photo-5212317.jpeg',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              semanticLabel:
                  'Professional female teacher with dark hair wearing glasses in academic setting',
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$greeting,',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                'Dr. Priya Sharma',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'school_outlined',
                    color: AppTheme.primary,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Delhi Public School',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Notification button
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: CustomIconWidget(
                  iconName: 'notifications_outlined',
                  color: theme.colorScheme.onSurface,
                  size: 22,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppTheme.warning,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
