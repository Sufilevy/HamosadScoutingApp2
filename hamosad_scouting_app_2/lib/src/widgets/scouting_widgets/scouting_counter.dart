import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:xcontext/material.dart';

class ScoutingCounter extends StatefulWidget {
  final Cubit<num> cubit;
  final double size;
  final String title;
  final num min, max, step;
  final num? initial;

  const ScoutingCounter({
    Key? key,
    required this.cubit,
    required this.min,
    required this.max,
    required this.step,
    this.size = 1,
    this.title = '',
    this.initial,
  })  : assert(min >= -99),
        assert(max <= 999),
        assert(step > 0),
        assert(max > min + step),
        super(key: key);

  static ScoutingCounter fromJSON({
    required Map<String, dynamic> json,
    required Cubit<num> cubit,
    double size = 1,
  }) {
    assert(json.containsKey('min'));
    assert(json.containsKey('max'));
    assert(json.containsKey('step'));

    return ScoutingCounter(
      cubit: cubit,
      size: size,
      title: json['title'] ?? '',
      min: json['min'],
      max: json['max'],
      step: json['step'],
      initial: json['initial'],
    );
  }

  @override
  State<ScoutingCounter> createState() => _ScoutingCounterState();
}

class _ScoutingCounterState extends State<ScoutingCounter> {
  @override
  void initState() {
    widget.cubit.data = (widget.initial) ??
        (widget.step is int
            ? (widget.min + widget.max) ~/ 2
            : (widget.min + widget.max) / 2);
    super.initState();
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

  Widget _iconButton(
    BuildContext context,
    void Function() onPressed,
    IconData icon,
  ) {
    return CircleAvatar(
      backgroundColor: context.theme.primaryColor,
      radius: 24 * widget.size,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        color: context.theme.backgroundColor,
        iconSize: 28 * widget.size,
        splashRadius: 24 * widget.size,
      ),
    );
  }

  Widget _counterText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * widget.size),
      child: Container(
        width: 90 * widget.size,
        height: 70 * widget.size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8 * widget.size),
          border: Border.all(
            color: context.theme.primaryColor,
            width: 3,
          ),
        ),
        padding: EdgeInsets.all(12 * widget.size),
        child: RepaintBoundary(
          child: AnimatedSwitcher(
            duration: 150.ms,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Text(
              widget.cubit.data.toString(),
              style: context.theme.textTheme.labelMedium,
              key: ValueKey<String>(
                widget.cubit.data.toString(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _counter() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _iconButton(context, _decrement, Icons.remove),
          _counterText(context),
          _iconButton(context, _increment, Icons.add),
        ],
      );

  @override
  Widget build(BuildContext context) {
    if (widget.title.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 32 * widget.size),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child: Text(
                widget.title,
                style: context.theme.textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
            _counter(),
          ],
        ),
      );
    } else {
      return _counter();
    }
  }
}
