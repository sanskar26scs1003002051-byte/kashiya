import 'package:flutter/material.dart';

import '../core/app_export.dart';

class _TabSpec {
  final String label;
  final String iconName;
  final String selectedIconName;
  final int? branchIndex;
  const _TabSpec({
    required this.label,
    required this.iconName,
    required this.selectedIconName,
    this.branchIndex,
  });
}

class AppNavigation extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const AppNavigation({required this.navigationShell, super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _selectedVisualIndex = 0;

  static const List<_TabSpec> _tabs = [
    _TabSpec(
      label: 'Home',
      iconName: 'home_outlined',
      selectedIconName: 'home_rounded',
      branchIndex: 0,
    ),
    _TabSpec(
      label: 'VAK Test',
      iconName: 'psychology_outlined',
      selectedIconName: 'psychology',
      branchIndex: 1,
    ),
    _TabSpec(
      label: 'Planner',
      iconName: 'calendar_month_outlined',
      selectedIconName: 'calendar_month',
      branchIndex: 2,
    ),
    _TabSpec(
      label: 'Students',
      iconName: 'group_outlined',
      selectedIconName: 'group',
      branchIndex: null,
    ),
    _TabSpec(
      label: 'Settings',
      iconName: 'settings_outlined',
      selectedIconName: 'settings',
      branchIndex: null,
    ),
  ];

  void _onTabTap(int visualIndex) {
    final tab = _tabs[visualIndex];
    if (tab.branchIndex == null) return; // stub tab — silently ignore
    setState(() => _selectedVisualIndex = visualIndex);
    widget.navigationShell.goBranch(
      tab.branchIndex!,
      initialLocation: tab.branchIndex == widget.navigationShell.currentIndex,
    );
  }

  @override
  void didUpdateWidget(AppNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync visual index with shell index
    final shellIdx = widget.navigationShell.currentIndex;
    for (int i = 0; i < _tabs.length; i++) {
      if (_tabs[i].branchIndex == shellIdx) {
        if (_selectedVisualIndex != i) {
          setState(() => _selectedVisualIndex = i);
        }
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(46),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_tabs.length, (i) {
              final tab = _tabs[i];
              final isActive = i == _selectedVisualIndex;
              final isStub = tab.branchIndex == null;
              return GestureDetector(
                onTap: () => _onTabTap(i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedOpacity(
                  opacity: isStub ? 0.4 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: SizedBox(
                    width: 56,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutCubic,
                          width: isActive ? 44 : 32,
                          height: isActive ? 36 : 32,
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xFF6C5CE7).withAlpha(64)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              isActive ? 20 : 16,
                            ),
                          ),
                          child: Center(
                            child: CustomIconWidget(
                              iconName: isActive
                                  ? tab.selectedIconName
                                  : tab.iconName,
                              color: isActive
                                  ? const Color(0xFFA29BFE)
                                  : Colors.white.withAlpha(153),
                              size: isActive ? 22 : 20,
                            ),
                          ),
                        ),
                        if (isActive) ...[
                          const SizedBox(height: 2),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              tab.label,
                              style: const TextStyle(
                                color: Color(0xFFA29BFE),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
