import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import '/models/cubit.dart';
import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class ScoutingCounter extends StatefulWidget {
  const ScoutingCounter({
    Key? key,
    required this.cubit,
    required this.min,
    required this.max,
    required this.step,
    this.title = '',
    this.initial,
  })  : assert(min >= -99),
        assert(max <= 999),
        assert(step > 0),
        assert(max > min + step),
        super(key: key);

  final Cubit<num> cubit;
  final num? initial;
  final num min, max, step;
  final String title;

  @override
  State<ScoutingCounter> createState() => _ScoutingCounterState();
}

class _ScoutingCounterState extends State<ScoutingCounter> {
  @override
  void initState() {
    widget.cubit.data = (widget.initial) ??
        (widget.step is int ? (widget.min + widget.max) ~/ 2 : (widget.min + widget.max) / 2);
    super.initState();
  }

  Widget _buildIconButton(
    BuildContext context,
    void Function() onPressed,
    IconData icon,
  ) {
    return CircleAvatar(
      backgroundColor: ScoutingTheme.primary,
      radius: 32.0 * ScoutingTheme.appSizeRatio,
      child: IconButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        icon: Icon(icon),
        color: ScoutingTheme.background1,
        iconSize: 32.0 * ScoutingTheme.appSizeRatio,
        splashRadius: 42.0 * ScoutingTheme.appSizeRatio,
      ),
    );
  }

  Widget _buildCounterText(BuildContext context) {
    return padSymmetric(
      horizontal: 16.0,
      Container(
        width: 110.0 * ScoutingTheme.appSizeRatio,
        height: 80.0 * ScoutingTheme.appSizeRatio,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0 * ScoutingTheme.appSizeRatio),
          border: Border.all(
            color: ScoutingTheme.primary,
            width: 2.0,
          ),
        ),
        padding: EdgeInsets.all(12.0 * ScoutingTheme.appSizeRatio),
        child: RepaintBoundary(
          child: AnimatedSwitcher(
            duration: 150.milliseconds,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Container(
              key: ValueKey<String>(widget.cubit.data.toString()),
              child: ScoutingText.subtitle(widget.cubit.data.toString()),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIconButton(context, _decrement, Icons.remove),
        _buildCounterText(context),
        _buildIconButton(context, _increment, Icons.add),
      ],
    );
  }

  void _increment() {
    if (widget.cubit.data + widget.step <= widget.max) {
      setState(() {
        widget.cubit.data += widget.step;
      });
    }
  }

  void _decrement() {
    if (widget.cubit.data - widget.step >= widget.min) {
      setState(() {
        widget.cubit.data -= widget.step;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.title.isNotEmpty) {
      return padSymmetric(
        horizontal: 32.0,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: ScoutingText.subtitle(
                widget.title,
                textAlign: TextAlign.center,
              ).padSymmetric(horizontal: 12.0),
            ),
            _buildCounter(),
          ],
        ),
      );
    } else {
      return _buildCounter();
    }
  }
}
