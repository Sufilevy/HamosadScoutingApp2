import 'package:flutter/material.dart';

import '/models/cubit.dart';

class ScoutingMicScores extends StatefulWidget {
  const ScoutingMicScores({
    super.key,
    required this.cubit,
  });

  final Cubit<int?> cubit;

  @override
  State<ScoutingMicScores> createState() => _ScoutingMicScoresState();
}

class _ScoutingMicScoresState extends State<ScoutingMicScores> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
