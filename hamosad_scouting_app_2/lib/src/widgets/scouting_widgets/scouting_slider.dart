import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';

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
    return Color.lerp(
          ScoutingTheme.primaryVariant,
          ScoutingTheme.primary,
          widget.cubit.data / (widget.max - widget.min),
        ) ??
        ScoutingTheme.primary;
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
            inactiveColor: ScoutingTheme.background3,
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
              child: ScoutingText.title(
                widget.title,
                textAlign: TextAlign.center,
              ),
            ),
          _slider(),
          if (widget.subtitle.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32 * widget.size),
              child: ScoutingText.text(
                widget.subtitle,
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
