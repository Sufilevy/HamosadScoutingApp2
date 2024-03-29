import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';

class ScoutingReportTab extends StatelessWidget {
  final String title;
  final List children;
  final double size;
  final double seperation;
  final bool seperated;

  ScoutingReportTab({
    Key? key,
    required this.title,
    required children,
    this.size = 1.0,
    this.seperation = 30.0,
    this.seperated = true,
  })  : children = [...children, Container()],
        super(key: key) {
    assert(children.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
          left: 40.0 * size,
          right: 40.0 * size,
          top: 30.0 * size,
        ),
        child: Container(
          height: 1.5,
          decoration: BoxDecoration(
            color: (seperated && index < children.length - 2)
                ? ScoutingTheme.background3
                : Colors.transparent,
            borderRadius: BorderRadius.circular(1.0),
          ),
        ),
      ),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(top: seperation * size),
        child: Center(child: children[index]),
      ),
      itemCount: children.length,
    );
  }
}
