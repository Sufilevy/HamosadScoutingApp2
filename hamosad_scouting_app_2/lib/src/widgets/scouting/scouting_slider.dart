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

  Color _sliderColor() {
    HSVColor hsv = HSVColor.fromColor(context.theme.toggleableActiveColor);
    return Color.lerp(
          hsv.withValue((hsv.value - 0.4).clamp(0, 1)).toColor(),
          context.theme.toggleableActiveColor,
          widget.cubit.data / (widget.max - widget.min),
        ) ??
        context.theme.toggleableActiveColor;
  }

  Widget _slider() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16 * widget.size),
        child: RepaintBoundary(
          child: Slider(
            value: widget.cubit.data.toDouble(),
            onChanged: (value) => setState(() {
              widget.cubit.data = value.toInt();
            }),
            thumbColor: _sliderColor(),
            activeColor: _sliderColor(),
            divisions: (widget.max - widget.min) ~/ widget.step,
            label: widget.cubit.data.toString(),
            min: widget.min.toDouble(),
            max: widget.max.toDouble(),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (widget.title.isNotEmpty || widget.subtitle.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.title.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32 * widget.size),
              child: Text(
                widget.title,
                style: context.theme.textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
          _slider(),
          if (widget.subtitle.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32 * widget.size),
              child: Text(
                widget.subtitle,
                style: TextStyle(
                  fontSize: context.theme.textTheme.bodyLarge?.fontSize,
                  color: context.theme.textTheme.labelSmall?.color,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      );
    } else {
      return _slider();
    }
  }
}
