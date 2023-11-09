import 'package:flutter/material.dart';

import '/pages/compare/graphs.dart';
import '/widgets/analytics/analytics_graph.dart';
import '/widgets/horizontal_switcher.dart';
import '/widgets/padding.dart';
import '/widgets/text.dart';

class GraphWithSelection extends StatefulWidget {
  const GraphWithSelection({super.key, required this.selectedTeams, this.initialGraphIndex = 0});

  final List<String> selectedTeams;
  final int initialGraphIndex;

  static int decreaseIndex(int currentIndex) {
    final newIndex = currentIndex - 1;
    return newIndex < 0 ? Graph.allGraphs.length - 1 : newIndex;
  }

  static int increaseIndex(int currentIndex) {
    final newIndex = currentIndex + 1;
    return newIndex >= Graph.allGraphs.length ? 0 : newIndex;
  }

  @override
  State<GraphWithSelection> createState() => _GraphWithSelectionState();
}

class _GraphWithSelectionState extends State<GraphWithSelection> {
  late int _currentGraphIndex = widget.initialGraphIndex;
  bool _reverseAnimation = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: _onHorizontalSwipe,
      child: Column(
        children: [
          _GraphSelect(
            currentGraphIndex: _currentGraphIndex,
            reverseAnimation: _reverseAnimation,
            onSelectionChanged: (newGraphIndex, reverseAnimation) => setState(() {
              _currentGraphIndex = newGraphIndex;
              _reverseAnimation = reverseAnimation;
            }),
          ).padBottom(4),
          HorizontalSwitcher(
            data: _currentGraphIndex,
            reverseAnimation: _reverseAnimation,
            child: const AnalyticsGraph(),
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
        _currentGraphIndex = GraphWithSelection.decreaseIndex(_currentGraphIndex);
      });
    } else if (details.primaryVelocity! < -sensitivity) {
      setState(() {
        _reverseAnimation = false;
        _currentGraphIndex = GraphWithSelection.increaseIndex(_currentGraphIndex);
      });
    }
  }
}

class _GraphSelect extends StatefulWidget {
  const _GraphSelect(
      {required this.currentGraphIndex,
      required this.reverseAnimation,
      required this.onSelectionChanged});

  final int currentGraphIndex;
  final bool reverseAnimation;
  final void Function(int newGraphIndex, bool reverseAnimation) onSelectionChanged;

  @override
  State<_GraphSelect> createState() => _GraphSelectState();
}

class _GraphSelectState extends State<_GraphSelect> {
  @override
  Widget build(BuildContext context) {
    final graphName = Graph.allGraphs[widget.currentGraphIndex].title;

    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _changeSelectionButton(isDecreaseButton: true),
          HorizontalSwitcher(
            data: graphName,
            reverseAnimation: widget.reverseAnimation,
            child: dataTitleText(graphName),
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
            ? GraphWithSelection.decreaseIndex(widget.currentGraphIndex)
            : GraphWithSelection.increaseIndex(widget.currentGraphIndex);

        widget.onSelectionChanged(newIndex, isDecreaseButton);
      },
    );
  }
}
