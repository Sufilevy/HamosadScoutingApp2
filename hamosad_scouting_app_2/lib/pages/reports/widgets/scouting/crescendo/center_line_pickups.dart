import 'package:flutter/material.dart';

import '/models/cubit.dart';

class ScoutingCenterLinePickups extends StatefulWidget {
  const ScoutingCenterLinePickups({
    super.key,
    required this.cubit,
  });

  final Cubit<List<int>> cubit;

  @override
  State<ScoutingCenterLinePickups> createState() => ScoutingCenterLinePickupsState();
}

class ScoutingCenterLinePickupsState extends State<ScoutingCenterLinePickups> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
