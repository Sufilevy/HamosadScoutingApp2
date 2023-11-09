import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '/models/report/report_model.dart';
import '/theme.dart';
import '/widgets/text.dart';

class Graphs extends StatefulWidget {
  const Graphs({super.key, required this.selectedTeams});

  final List<String> selectedTeams;

  @override
  State<Graphs> createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
  int _currentGraphIndex = 0;
  bool _reverseAnimation = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _GraphSelect(
          onSelectionChanged: (newGraphIndex, selectionIndexDecreased) => setState(() {
            _currentGraphIndex = newGraphIndex;
            _reverseAnimation = selectionIndexDecreased;
          }),
        ),
        _graph(),
      ],
    );
  }

  Widget _graph() {
    final graph = _graphs[_currentGraphIndex];

    return PageTransitionSwitcher(
      reverse: _reverseAnimation,
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          fillColor: AnalyticsTheme.background2,
          child: child,
        );
      },
      child: Container(
        key: ValueKey(graph.title),
        child: dataTitleText(graph.data(Report())),
      ),
    );
  }
}

class _GraphSelect extends StatefulWidget {
  const _GraphSelect({required this.onSelectionChanged});

  final void Function(int newGraphIndex, bool selectionIndexDecreased) onSelectionChanged;

  @override
  State<_GraphSelect> createState() => _GraphSelectState();
}

class _GraphSelectState extends State<_GraphSelect> {
  int _currentGraphIndex = 0;
  bool _reverseAnimation = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _changeSelectionButton(isDecreaseButton: true),
          _graphName(),
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
      onPressed: () => setState(() {
        _reverseAnimation = isDecreaseButton;

        if (_shouldLoopIndex(isDecreaseButton)) {
          _currentGraphIndex = isDecreaseButton ? _graphs.length - 1 : 0;
        } else {
          _currentGraphIndex += isDecreaseButton ? -1 : 1;
        }

        widget.onSelectionChanged(_currentGraphIndex, isDecreaseButton);
      }),
    );
  }

  bool _shouldLoopIndex(bool isDecreaseButton) {
    final newIndex = _currentGraphIndex + (isDecreaseButton ? -1 : 1);
    return newIndex < 0 || newIndex >= _graphs.length;
  }

  Widget _graphName() {
    final graphName = _graphs[_currentGraphIndex].title;

    return PageTransitionSwitcher(
      reverse: _reverseAnimation,
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          fillColor: AnalyticsTheme.background2,
          child: child,
        );
      },
      child: Container(
        key: ValueKey(graphName),
        child: dataTitleText(graphName),
      ),
    );
  }
}

class _Graph {
  const _Graph({required this.title, required this.data});

  final String title;
  final double Function(Report) data;
}

final _graphs = <_Graph>[
  _Graph(title: 'Total Score', data: (report) => Report.randomData(70)),
  _Graph(title: 'Auto Dropoffs', data: (report) => Report.randomData(6)),
  _Graph(title: 'Teleop Dropoffs', data: (report) => Report.randomData(15)),
];
