import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '/widgets/paddings.dart';

class ChipRow extends StatelessWidget {
  const ChipRow({
    super.key,
    this.padding,
    this.smallChips = false,
    this.flexes,
    required this.children,
  });

  final bool smallChips;
  final double? padding;
  final List<int>? flexes;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return padBottom(
      10.0,
      Row(
        children: children
            .mapIndexed(
              (index, child) => Expanded(
                flex: flexes?[index] ?? 1,
                child: _padChild(index, child),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _padChild(int index, Widget child) =>
      (index == children.lastIndex) ? child : child.padRight(padding ?? _chipPadding);

  double get _chipPadding => smallChips ? 5.0 : 8.0;
}
