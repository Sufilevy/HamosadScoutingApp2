import 'package:flutter/material.dart';

import '/models/cubit.dart';

class ScoutingMiddlePickups extends StatefulWidget {
  const ScoutingMiddlePickups({
    super.key,
    required this.cubit,
  });

  final Cubit<List<int>> cubit;

  @override
  State<ScoutingMiddlePickups> createState() => ScoutingMiddlePickupsState();
}

class ScoutingMiddlePickupsState extends State<ScoutingMiddlePickups> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
