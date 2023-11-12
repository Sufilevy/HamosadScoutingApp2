import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '/models/cubit.dart';
import '/theme.dart';
import '/widgets/circle_painter.dart';
import '/widgets/icon_button.dart';
import '/widgets/text.dart';

class ScoutingStopwatch extends StatefulWidget {
  const ScoutingStopwatch({
    super.key,
    required this.cubit,
    this.lapLength = 5000,
  });

  final Cubit<double> cubit;
  final int lapLength;

  @override
  State<ScoutingStopwatch> createState() => _ScoutingStopwatchState();
}

class _ScoutingStopwatchState extends State<ScoutingStopwatch> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final _stopwatch = Stopwatch();
  var _timer = Timer(0.milliseconds, () {});

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(duration: 250.milliseconds, vsync: this);
    super.initState();
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

  String get _seconds => _stopwatch.elapsed.inSeconds.toString().padLeft(2, '0');
  String get _milliseconds =>
      (_stopwatch.elapsed.inMilliseconds ~/ 10 % 100).toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final size = 280 * ScoutingTheme.appSizeRatio;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: CirclePainter(
                color: ScoutingTheme.secondary,
                strokeWidth: 13 * ScoutingTheme.appSizeRatio,
                progress:
                    (_stopwatch.elapsed.inMilliseconds % widget.lapLength) / widget.lapLength * 100,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScoutingText.navigation(
                '$_seconds:$_milliseconds',
                fontSize: 50 * ScoutingTheme.appSizeRatio,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScoutingIconButton(
                    icon: Icons.stop,
                    color: _stopwatch.isRunning ? ScoutingTheme.foreground2 : ScoutingTheme.primary,
                    iconSize: 60 * ScoutingTheme.appSizeRatio,
                    isEnabled: !_stopwatch.isRunning,
                    onPressed: _reset,
                  ),
                  ScoutingIconButton(
                    iconWidget: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: _controller,
                      color: ScoutingTheme.primary,
                      size: 60 * ScoutingTheme.appSizeRatio,
                    ),
                    iconSize: 60 * ScoutingTheme.appSizeRatio,
                    color: _stopwatch.isRunning ? ScoutingTheme.foreground2 : ScoutingTheme.primary,
                    onPressed: () => setState(() {
                      _stopwatch.isRunning ? _stop() : _start();
                    }),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
