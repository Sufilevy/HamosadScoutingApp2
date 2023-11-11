import 'package:flutter/material.dart';

import '/pages/compare/charts.dart';
import '/widgets/horizontal_switcher.dart';
import '/widgets/padding.dart';
import '/widgets/text.dart';
import 'analytics_chart.dart';

class ChartWithSelection extends StatefulWidget {
  const ChartWithSelection({super.key, required this.selectedTeams, this.initialChartIndex = 0});

  final List<String> selectedTeams;
  final int initialChartIndex;

  static int decreaseIndex(int currentIndex) {
    final newIndex = currentIndex - 1;
    return newIndex < 0 ? Charts.charts.length - 1 : newIndex;
  }

  static int increaseIndex(int currentIndex) {
    final newIndex = currentIndex + 1;
    return newIndex >= Charts.charts.length ? 0 : newIndex;
  }

  @override
  State<ChartWithSelection> createState() => _ChartWithSelectionState();
}

class _ChartWithSelectionState extends State<ChartWithSelection> {
  late int _currentChartIndex = widget.initialChartIndex;
  bool _reverseAnimation = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: _onHorizontalSwipe,
      child: Column(
        children: [
          _ChartSelect(
            currentChartIndex: _currentChartIndex,
            reverseAnimation: _reverseAnimation,
            onSelectionChanged: (newChartIndex, reverseAnimation) => setState(() {
              _currentChartIndex = newChartIndex;
              _reverseAnimation = reverseAnimation;
            }),
          ).padBottom(4),
          HorizontalSwitcher(
            data: _currentChartIndex,
            reverseAnimation: _reverseAnimation,
            child: const AnalyticsChart(),
          ),
        ],
      ),
    );
  }

  void _onHorizontalSwipe(DragEndDetails? details) {
    const sensitivity = 250.0;

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
  const _ChartSelect(
      {required this.currentChartIndex,
      required this.reverseAnimation,
      required this.onSelectionChanged});

  final int currentChartIndex;
  final bool reverseAnimation;
  final void Function(int newChartIndex, bool reverseAnimation) onSelectionChanged;

  @override
  State<_ChartSelect> createState() => _ChartSelectState();
}

class _ChartSelectState extends State<_ChartSelect> {
  @override
  Widget build(BuildContext context) {
    final chartName = Charts.charts[widget.currentChartIndex].title;

    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
