import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/theme.dart';
import 'package:hamosad_scouting_app_2/widgets/paddings.dart';

class ReportTab extends StatelessWidget {
  final String title;
  final List children;

  final double seperation;
  final bool seperated;

  ReportTab({
    Key? key,
    required this.title,
    required children,
    this.seperation = 30.0,
    this.seperated = true,
  })  : children = [...children, Container()],
        super(key: key) {
    assert(children.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => padLTRB(
        40.0,
        30.0,
        40.0,
        0.0,
        Container(
          height: 1.5,
          decoration: BoxDecoration(
            color: (seperated && index < children.length - 2)
                ? ScoutingTheme.background3
                : Colors.transparent,
            borderRadius: BorderRadius.circular(1.0),
          ),
        ),
      ),
      itemBuilder: (context, index) => Center(child: children[index]).padTop(seperation),
      itemCount: children.length,
    );
  }
}
