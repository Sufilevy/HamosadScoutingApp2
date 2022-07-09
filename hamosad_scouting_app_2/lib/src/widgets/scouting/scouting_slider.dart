import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/other/cubit.dart';
import 'package:xcontext/material.dart';

class ScoutingSlider extends StatefulWidget {
  final Cubit<int> cubit;
  final double size;
  final String title, subtitle;
  final int min, max, step;
  final int? initial;

  const ScoutingSlider({
    Key? key,
    required this.cubit,
    required this.min,
    required this.max,
    required this.step,
    this.size = 1,
    this.title = '',
    this.subtitle = '',
    this.initial,
  })  : assert(max <= 100),
        assert(min >= -100),
        assert(step > 0),
        assert(max > min + step),
        assert(initial == null || (initial >= min && initial <= max)),
        super(key: key);

  static ScoutingSlider fromJSON({
    required Map<String, dynamic> json,
    required Cubit<int> cubit,
    double size = 1,
  }) {
    assert(json.containsKey('min'));
    assert(json.containsKey('max'));
    assert(json.containsKey('step'));

    return ScoutingSlider(
      cubit: cubit,
      size: size,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      min: json['min']!,
      max: json['max']!,
      step: json['step']!,
      initial: json['initial'],
    );
  }

  @override
  State<ScoutingSlider> createState() => _ScoutingSliderState();
}

class _ScoutingSliderState extends State<ScoutingSlider> {
  @override
  void initState() {
    if (widget.initial != null) {
      widget.cubit.data = widget.initial!;
    } else {
      widget.cubit.data = ((widget.min + widget.max) / 2).ceil();
    }
    super.initState();
  }

  Widget _slider() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16 * widget.size),
        child: Slider(
          value: widget.cubit.data.toDouble(),
          onChanged: (value) => setState(() {
            widget.cubit.data = value.toInt();
          }),
          thumbColor: context.theme.toggleableActiveColor,
          activeColor: context.theme.toggleableActiveColor,
          divisions: (widget.max - widget.min) ~/ widget.step,
          label: widget.cubit.data.toString(),
          min: widget.min.toDouble(),
          max: widget.max.toDouble(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (widget.title.isNotEmpty || widget.subtitle.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.title.isNotEmpty)
            Text(
              widget.title,
              style: context.theme.textTheme.bodyLarge,
            ),
          _slider(),
          if (widget.subtitle.isNotEmpty)
            Text(
              widget.subtitle,
              style: context.theme.textTheme.bodyMedium,
            ),
        ],
      );
    } else {
      return _slider();
    }
  }
}
