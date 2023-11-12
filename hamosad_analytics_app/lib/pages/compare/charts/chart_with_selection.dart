import 'package:flutter/material.dart';

import '/services/utilities.dart';
import '/widgets/analytics.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';
import 'analytics_chart.dart';
import 'charts.dart';

class ChartWithSelection extends StatefulWidget {
  const ChartWithSelection({
    super.key,
    required this.selectedTeams,
    required this.teamsWithReports,
    this.initialChartIndex = 0,
  });

  final List<String> selectedTeams;
  final TeamsWithReports teamsWithReports;
  final int initialChartIndex;

  static int decreaseIndex(int currentIndex) {
    final newIndex = currentIndex - 1;
    return newIndex < 0 ? Charts.length - 1 : newIndex;
  }

  static int increaseIndex(int currentIndex) {
    final newIndex = currentIndex + 1;
    return newIndex >= Charts.length ? 0 : newIndex;
  }

  @override
  State<ChartWithSelection> createState() => _ChartWithSelectionState();
}

class _ChartWithSelectionState extends State<ChartWithSelection> {
  late int _currentChartIndex = widget.initialChartIndex;
  bool _reverseAnimation = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onHorizontalDragEnd: _onHorizontalSwipe,
          child: _chartSelect().padBottom(4),
        ),
        GestureDetector(
          onHorizontalDragEnd: _isChartSwipeEnabled(context)
              ? (details) => _onHorizontalSwipe(details, sensitivity: 300)
              : null,
          child: _chart(),
        ),
      ],
    );
  }

  bool _isChartSwipeEnabled(BuildContext context) {
    final screenWidth = context.screenSize.width;
    final maxWidth = AnalyticsChart.maxChartWidth(screenWidth, widget.teamsWithReports);
    return maxWidth == screenWidth - 32;
  }

  Widget _chartSelect() {
    return _ChartSelect(
      currentChartIndex: _currentChartIndex,
      reverseAnimation: _reverseAnimation,
      onSelectionChanged: (newChartIndex, reverseAnimation) => setState(() {
        _currentChartIndex = newChartIndex;
        _reverseAnimation = reverseAnimation;
      }),
    );
  }

  Widget _chart() {
    return HorizontalSwitcher(
      data: _currentChartIndex,
      reverseAnimation: _reverseAnimation,
      child: AnalyticsChart(
        dataFromReport: Charts.index(_currentChartIndex).dataFromReport,
        teamsWithReports: widget.teamsWithReports,
      ),
    );
  }

  void _onHorizontalSwipe(DragEndDetails? details, {double sensitivity = 250}) {
    if (details == null) return;

    if (details.primaryVelocity! > sensitivity) {
      setState(() {
        _reverseAnimation = true;
        _currentChartIndex = ChartWithSelection.decreaseIndex(_currentChartIndex);
      });
    } else if (details.primaryVelocity! < -sensitivity) {
      setState(() {
        _reverseAnimation = false;
        _currentChartIndex = ChartWithSelection.increaseIndex(_currentChartIndex);
      });
    }
  }
}

class _ChartSelect extends StatefulWidget {
  const _ChartSelect({
    required this.currentChartIndex,
    required this.reverseAnimation,
    required this.onSelectionChanged,
  });

  final int currentChartIndex;
  final bool reverseAnimation;
  final void Function(int newChartIndex, bool reverseAnimation) onSelectionChanged;

  @override
  State<_ChartSelect> createState() => _ChartSelectState();
}

class _ChartSelectState extends State<_ChartSelect> {
  @override
  Widget build(BuildContext context) {
    final chartName = Charts.index(widget.currentChartIndex).title;

    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _changeSelectionButton(isDecreaseButton: true),
          HorizontalSwitcher(
            data: chartName,
            reverseAnimation: widget.reverseAnimation,
            child: dataTitleText(chartName),
          ),
          _changeSelectionButton(isDecreaseButton: false),
        ],
      ),
    );
  }

  Widget _changeSelectionButton({required bool isDecreaseButton}) {
    return IconButton(
      icon: Icon(
        isDecreaseButton ? Icons.keyboard_arrow_left_rounded : Icons.keyboard_arrow_right_rounded,
      ),
      onPressed: () {
        var newIndex = isDecreaseButton
            ? ChartWithSelection.decreaseIndex(widget.currentChartIndex)
            : ChartWithSelection.increaseIndex(widget.currentChartIndex);

        widget.onSelectionChanged(newIndex, isDecreaseButton);
      },
    );
  }
}
