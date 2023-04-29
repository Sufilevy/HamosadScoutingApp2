import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/theme.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';

class ScoutingStopwatch extends StatefulWidget {
  const ScoutingStopwatch({
    Key? key,
    required this.cubit,
    this.lapLength = 5000,
    this.width = 250,
    this.height = 250,
  }) : super(key: key);

  final Cubit<double> cubit;
  final int lapLength;
  final double width, height;

  @override
  State<ScoutingStopwatch> createState() => _ScoutingStopwatchState();
}

class _ScoutingStopwatchState extends State<ScoutingStopwatch>
    with SingleTickerProviderStateMixin {
  final Stopwatch _stopwatch = Stopwatch();
  Timer _timer = Timer(0.milliseconds, () {});
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: 250.milliseconds, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width * ScoutingTheme.appSizeRatio,
      height: widget.height * ScoutingTheme.appSizeRatio,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: widget.width * ScoutingTheme.appSizeRatio,
              height: widget.height * ScoutingTheme.appSizeRatio,
              child: CustomPaint(
                painter: CirclePainter(
                  color: Colors.indigo,
                  strokeWidth: 10,
                  progress:
                      (_stopwatch.elapsed.inMilliseconds % widget.lapLength) /
                          widget.lapLength *
                          100,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_stopwatch.elapsed.inSeconds.toString().padLeft(2, '0')}:${(_stopwatch.elapsed.inMilliseconds ~/ 10 % 100).toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.stop),
                      color: ScoutingTheme.primary
                          .withOpacity(_stopwatch.isRunning ? 1.0 : 0.5),
                      iconSize: 24.0 * ScoutingTheme.appSizeRatio,
                      onPressed: () => _stopwatch.isRunning ? null : _reset(),
                      splashColor: Colors.transparent,
                    ),
                    GestureDetector(
                      onTap: () => setState(
                        () => _stopwatch.isRunning ? _stop() : _start(),
                      ),
                      child: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: _controller,
                        color: ScoutingTheme.foreground2,
                        size: 24.0 * ScoutingTheme.appSizeRatio,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _start() {
    _timer = Timer.periodic(10.milliseconds, (_) => setState(() {}));
    _stopwatch.start();
    _controller.forward();
  }

  void _stop() {
    _timer.cancel();
    _stopwatch.stop();
    _controller.reverse();
  }

  void _reset() {
    setState(() {
      _stopwatch.reset();
      _timer.cancel();
    });
  }
}
