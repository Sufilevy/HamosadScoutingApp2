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
      14,
      Row(
        children: children
            .mapIndexed(
              (index, child) => _expandChild(index, _padChild(index, child)),
            )
            .toList(),
      ),
    );
  }

  Widget _expandChild(int index, Widget child) {
    return Expanded(
      flex: flexes?.elementAtOrNull(index) ?? 1,
      child: child,
    );
  }

  Widget _padChild(int index, Widget child) {
    return (index == children.lastIndex) ? child : child.padRight(padding ?? _chipPadding);
  }

  double get _chipPadding => smallChips ? 8 : 12;
}