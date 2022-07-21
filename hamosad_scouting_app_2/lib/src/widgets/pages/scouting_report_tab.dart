import 'package:flutter/material.dart';

class ScoutingReportTab extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final double size;
  final double seperation;

  ScoutingReportTab({
    Key? key,
    required this.title,
    required children,
    this.size = 1.0,
    this.seperation = 48,
  })  : children = [...children, Container()],
        super(key: key) {
    assert(children.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(top: seperation * size),
        child: Center(child: children[index]),
      ),
      itemCount: children.length,
    );
  }
}
