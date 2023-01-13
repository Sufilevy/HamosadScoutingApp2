import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/models.dart';
import 'package:hamosad_analytics_app/src/widgets/analytics/analytics_text.dart';

enum AnalyticsTab {
  general(Icons.assessment_outlined, Icons.assessment_rounded, 'General'),
  autonomous(Icons.code_rounded, Icons.code_outlined, 'Autonomous'),
  teleop(Icons.person_outline_rounded, Icons.person_rounded, 'Teleop'),
  endgame(Icons.timer_outlined, Icons.timer_rounded, 'Endgame');

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
        _tabButton(AnalyticsTab.general),
        _seperator,
        _tabButton(AnalyticsTab.autonomous),
        _seperator,
        _tabButton(AnalyticsTab.teleop),
        _seperator,
        _tabButton(AnalyticsTab.endgame),
      ],
    );
  }

  Widget _tabButton(AnalyticsTab tab) {
    bool isSelected = widget.currentTabCubit.data == tab;
    Color color =
        isSelected ? AnalyticsTheme.primary : AnalyticsTheme.foreground1;

    return Expanded(
      flex: 16,
      child: SizedBox(
        height: 40.0,
        child: ElevatedButton.icon(
          onPressed: () => setState(() {
            widget.currentTabCubit.data = tab;
            widget.onTabSelected?.call();
          }),
          icon: Icon(
            isSelected ? tab.selectedIcon : tab.icon,
            color: color,
            size: 32.0,
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

  Widget get _seperator => Expanded(flex: 1, child: Container());
}
