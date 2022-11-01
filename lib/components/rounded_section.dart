
import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedSection extends StatelessWidget {
  const RoundedSection({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context){
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(Consts.defultBorderRadiusSize),
        topRight: Radius.circular(Consts.defultBorderRadiusSize)
      ),
      child: Container(
        color: Consts.sectionDefultColor,
        child: child,
      ),
    );
  }
}