import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/app.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/models.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

enum AnalyticsTab {
  general(Icons.assessment_outlined, Icons.assessment_rounded, 'General'),
  auto(Icons.code_rounded, Icons.code_outlined, 'Auto'),
  teleop(Icons.person_outline_rounded, Icons.person_rounded, 'Teleop'),
  endgame(Icons.timer_outlined, Icons.timer_rounded, 'Endgame'),
  notes(Icons.assignment_outlined, Icons.assignment_rounded, 'Notes');

  const AnalyticsTab(this.icon, this.selectedIcon, this.label);

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

class AnalyticsTabsSelector extends StatefulWidget {
  const AnalyticsTabsSelector({
    Key? key,
    required this.currentTabCubit,
    this.onTabSelected,
  }) : super(key: key);

  final Cubit<AnalyticsTab> currentTabCubit;
  final VoidCallback? onTabSelected;

  @override
  State<AnalyticsTabsSelector> createState() => _AnalyticsTabsSelectorState();
}

class _AnalyticsTabsSelectorState extends State<AnalyticsTabsSelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTabButton(AnalyticsTab.general),
        _buildSeperator(),
        _buildTabButton(AnalyticsTab.auto),
        _buildSeperator(),
        _buildTabButton(AnalyticsTab.teleop),
        _buildSeperator(),
        _buildTabButton(AnalyticsTab.endgame),
        _buildSeperator(),
        _buildTabButton(AnalyticsTab.notes),
      ],
    );
  }

  Widget _buildTabButton(AnalyticsTab tab) {
    bool isSelected = widget.currentTabCubit.data == tab;
    Color color =
        isSelected ? AnalyticsTheme.primary : AnalyticsTheme.foreground1;

    return Expanded(
      flex: 16,
      child: SizedBox(
        height: 40.0 * AnalyticsApp.size,
        child: ElevatedButton.icon(
          onPressed: () => setState(() {
            widget.currentTabCubit.data = tab;
            widget.onTabSelected?.call();
          }),
          icon: Icon(
            isSelected ? tab.selectedIcon : tab.icon,
            color: color,
            size: 32.0 * AnalyticsApp.size,
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(AnalyticsTheme.background2),
          ),
          label: AnalyticsText.dataSubtitle(
            tab.label,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildSeperator() => const EmptyExpanded(flex: 1);
}
