import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';

class ScoutingStopwatch extends StatefulWidget {
  final Cubit<double> cubit;
  final double size;
  final int lapLength;
  final double width, height;

  const ScoutingStopwatch({
    Key? key,
    required this.cubit,
    this.size = 1.0,
    this.lapLength = 5000,
    this.width = 250,
    this.height = 250,
  }) : super(key: key);

  @override
  State<ScoutingStopwatch> createState() => _ScoutingStopwatchState();
}

class _ScoutingStopwatchState extends State<ScoutingStopwatch>
    with SingleTickerProviderStateMixin {
  final Stopwatch _stopwatch = Stopwatch();
  Timer _timer = Timer(0.ms, () {});
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: 250.ms, vsync: this);
    super.initState();
  }

  void _start() {
    _timer = Timer.periodic(10.ms, (_) => setState(() {}));
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

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width * widget.size,
      height: widget.height * widget.size,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: widget.width * widget.size,
              height: widget.height * widget.size,
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
                      color: _stopwatch.isRunning
                          ? Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.color
                              ?.withOpacity(0.5)
                          : Theme.of(context).textTheme.labelMedium?.color,
                      iconSize: 24 * widget.size,
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
                        color: Theme.of(context).textTheme.labelMedium?.color,
                        size: 24 * widget.size,
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
}
