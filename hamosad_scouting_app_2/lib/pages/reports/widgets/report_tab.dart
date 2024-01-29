import 'package:flutter/material.dart';

import '/theme.dart';
import '/widgets/paddings.dart';

class ReportTab extends StatelessWidget {
  final String title;
  final List<Widget> children;

  final double seperation;
  final bool seperated;

  ReportTab({
    super.key,
    required this.title,
    required children,
    this.seperation = 48,
    this.seperated = true,
  }) : children = [...children, Container()] {
    assert(children.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => padSymmetric(
        horizontal: 64 * ScoutingTheme.appSizeRatio,
        vertical: seperation * ScoutingTheme.appSizeRatio,
        Container(
          height: 1.5,
          decoration: BoxDecoration(
            color: (seperated && index < children.length - 2)
                ? ScoutingTheme.background3
                : Colors.transparent,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ),
      itemBuilder: (context, index) => Center(
        child: index == 0 ? children[index].padTop(32) : children[index],
      ),
      itemCount: children.length,
    );
  }
}
