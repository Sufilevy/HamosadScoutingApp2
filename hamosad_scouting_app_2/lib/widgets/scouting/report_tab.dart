import 'package:flutter/material.dart';

import '/theme.dart';
import '/widgets/paddings.dart';

class ReportTab extends StatefulWidget {
  ReportTab({
    super.key,
    required this.title,
    required children,
    this.seperated = true,
  }) : children = [...children, Container()] {
    assert(children.isNotEmpty);
  }

  final String title;
  final List<Widget> children;

  final bool seperated;

  @override
  State<ReportTab> createState() => _ReportTabState();
}

class _ReportTabState extends State<ReportTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      separatorBuilder: (context, index) => padSymmetric(
        horizontal: 64,
        vertical: 32,
        Container(
          height: 1.5,
          decoration: BoxDecoration(
            color: (widget.seperated && index < widget.children.length - 2)
                ? ScoutingTheme.background3
                : Colors.transparent,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ),
      itemBuilder: (context, index) => Center(
        child: index == 0 ? widget.children[index].padTop(32) : widget.children[index],
      ),
      itemCount: widget.children.length,
    );
  }
}