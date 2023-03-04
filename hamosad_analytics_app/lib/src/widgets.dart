import 'package:flutter/material.dart';

export 'widgets/analytics.dart';
export 'widgets/graphs.dart';
export 'widgets/sidebar.dart';
export 'widgets/tab_selector.dart';
export 'widgets/team_search_bar.dart';

class EmptyExpanded extends StatelessWidget {
  const EmptyExpanded({
    Key? key,
    required this.flex,
  }) : super(key: key);

  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: flex, child: const SizedBox.shrink());
  }
}
