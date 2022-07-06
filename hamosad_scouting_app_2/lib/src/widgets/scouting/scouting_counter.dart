import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/json/cubit.dart';

class ScoutingCounter extends StatefulWidget {
  final Cubit<num> cubit;
  final double size;
  final String title;
  final num min, max, step;
  final num? initial;

  ScoutingCounter({
    Key? key,
    required this.cubit,
    required this.min,
    required this.max,
    required this.step,
    this.size = 1.0,
    this.title = '',
    this.initial,
  }) : super(key: key) {
    assert(max <= 999);
    assert(step > 0);
    assert(max > min + step);
  }

  static ScoutingCounter fromJSON({
    required Map<String, dynamic> json,
    required Cubit<num> cubit,
    double size = 1.0,
  }) {
    assert(json.containsKey('min'));
    assert(json.containsKey('max'));
    assert(json.containsKey('step'));

    return ScoutingCounter(
      cubit: cubit,
      size: size,
      title: json['title'] ?? '',
      min: json['min']!,
      max: json['max']!,
      step: json['step']!,
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
            ? (widget.min + widget.max) ~/ 2.0
            : (widget.min + widget.max) / 2.0);
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
      backgroundColor: Theme.of(context).primaryColor,
      radius: 20.0 * widget.size,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        color: Theme.of(context).backgroundColor,
        iconSize: 24.0 * widget.size,
        splashRadius: 24.0 * widget.size,
      ),
    );
  }

  Widget _counterText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0 * widget.size),
      child: Container(
        width: 90.0 * widget.size,
        height: 70.0 * widget.size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0 * widget.size),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 3.0,
          ),
        ),
        padding: EdgeInsets.all(12.0 * widget.size),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Text(
            widget.cubit.data.toString(),
            style: Theme.of(context).textTheme.labelMedium,
            key: ValueKey<String>(
              widget.cubit.data.toString(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (widget.title.isNotEmpty)
          Text(
            widget.title,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _iconButton(context, _decrement, Icons.remove_rounded),
            _counterText(context),
            _iconButton(context, _increment, Icons.add_rounded),
          ],
        )
      ],
    );
  }
}
