import 'package:flutter/material.dart';

class ScoutingPageBody extends StatelessWidget {
  final List<Widget> children;
  final double size;
  final double seperation;

  ScoutingPageBody({
    Key? key,
    required this.children,
    this.size = 1.0,
    this.seperation = 48,
  }) : super(key: key) {
    assert(children.isNotEmpty);
    children.add(Container());
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
