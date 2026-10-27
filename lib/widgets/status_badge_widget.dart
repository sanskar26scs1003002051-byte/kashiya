import 'package:flutter/material.dart';

enum BadgeType {
  visual,
  auditory,
  kinesthetic,
  untested,
  active,
  draft,
  completed,
  warning,
}

class StatusBadgeWidget extends StatelessWidget {
  final BadgeType type;
  final String? customLabel;
  const StatusBadgeWidget({required this.type, this.customLabel, super.key});

  @override
  Widget build(BuildContext context) {
    final config = _badgeConfig(type);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: config.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: config.dot,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            customLabel ?? config.label,
            style: TextStyle(
              color: config.text,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  _BadgeConfig _badgeConfig(BadgeType type) {
    switch (type) {
      case BadgeType.visual:
        return _BadgeConfig(
          background: const Color(0xFFE8F4FD),
          dot: const Color(0xFF74B9FF),
          text: const Color(0xFF0984E3),
          label: 'Visual',
        );
      case BadgeType.auditory:
        return _BadgeConfig(
          background: const Color(0xFFF3F0FF),
          dot: const Color(0xFFA29BFE),
          text: const Color(0xFF6C5CE7),
          label: 'Auditory',
        );
      case BadgeType.kinesthetic:
        return _BadgeConfig(
          background: const Color(0xFFE8FDF5),
          dot: const Color(0xFF55EFC4),
          text: const Color(0xFF00B894),
          label: 'Kinesthetic',
        );
      case BadgeType.untested:
        return _BadgeConfig(
          background: const Color(0xFFF5F5F5),
          dot: const Color(0xFFB2BEC3),
          text: const Color(0xFF636E72),
          label: 'Untested',
        );
      case BadgeType.active:
        return _BadgeConfig(
          background: const Color(0xFFE8FDF5),
          dot: const Color(0xFF00B894),
          text: const Color(0xFF00B894),
          label: 'Active',
        );
      case BadgeType.draft:
        return _BadgeConfig(
          background: const Color(0xFFFFF8E7),
          dot: const Color(0xFFFDCB6E),
          text: const Color(0xFFE17055),
          label: 'Draft',
        );
      case BadgeType.completed:
        return _BadgeConfig(
          background: const Color(0xFFE8FDF5),
          dot: const Color(0xFF00B894),
          text: const Color(0xFF00B894),
          label: 'Completed',
        );
      case BadgeType.warning:
        return _BadgeConfig(
          background: const Color(0xFFFFEBE6),
          dot: const Color(0xFFE17055),
          text: const Color(0xFFE17055),
          label: 'At Risk',
        );
    }
  }
}

class _BadgeConfig {
  final Color background;
  final Color dot;
  final Color text;
  final String label;
  const _BadgeConfig({
    required this.background,
    required this.dot,
    required this.text,
    required this.label,
  });
}
