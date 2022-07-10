import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ScoutingStopwatch extends StatefulWidget {
  const ScoutingStopwatch({Key? key}) : super(key: key);

  @override
  State<ScoutingStopwatch> createState() => _ScoutingStopwatchState();
}

class _ScoutingStopwatchState extends State<ScoutingStopwatch>
    with SingleTickerProviderStateMixin {
  Duration _elapsed = Duration.zero;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) => setState(() => _elapsed = elapsed));
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
