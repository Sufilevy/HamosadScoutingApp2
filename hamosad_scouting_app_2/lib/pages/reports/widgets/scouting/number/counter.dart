import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/models/cubit.dart';
import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class ScoutingCounter extends StatefulWidget {
  const ScoutingCounter({
    super.key,
    required this.cubit,
    required this.min,
    required this.max,
    this.step = 1,
    this.title = '',
    this.initial,
  })  : assert(min >= -99),
        assert(max <= 999),
        assert(step > 0),
        assert(max > min + step);

  final Cubit<int> cubit;
  final int min, max, step;
  final String title;
  final int? initial;

  @override
  State<ScoutingCounter> createState() => _ScoutingCounterState();
}

class _ScoutingCounterState extends State<ScoutingCounter> {
  @override
  void initState() {
    widget.cubit.data = widget.initial ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.title.isNotEmpty) {
      return padSymmetric(
        horizontal: 32,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child: ScoutingText.subtitle(
                widget.title,
                textAlign: TextAlign.center,
              ).padSymmetric(horizontal: 12),
            ),
            _buildCounter(),
          ],
        ),
      );
    } else {
      return _buildCounter();
    }
  }

  Widget _buildIconButton(
    BuildContext context,
    VoidCallback onPressed,
    IconData icon,
  ) {
    return CircleAvatar(
      backgroundColor: ScoutingTheme.primary,
      radius: 32 * ScoutingTheme.appSizeRatio,
      child: IconButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        icon: Icon(icon),
        color: ScoutingTheme.background1,
        iconSize: 32 * ScoutingTheme.appSizeRatio,
        splashRadius: 42 * ScoutingTheme.appSizeRatio,
      ),
    );
  }

  Widget _buildCounterText(BuildContext context) {
    return padSymmetric(
      horizontal: 16,
      Container(
        width: 110 * ScoutingTheme.appSizeRatio,
        height: 80 * ScoutingTheme.appSizeRatio,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8 * ScoutingTheme.appSizeRatio),
          border: Border.all(
            color: ScoutingTheme.primary,
            width: 2,
          ),
        ),
        padding: EdgeInsets.all(12 * ScoutingTheme.appSizeRatio),
        child: RepaintBoundary(
          child: AnimatedSwitcher(
            duration: 100.milliseconds,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
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
      children: <Widget>[
        _buildIconButton(context, _decrement, FontAwesomeIcons.minus),
        _buildCounterText(context),
        _buildIconButton(context, _increment, FontAwesomeIcons.plus),
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
}
