import 'package:flutter/material.dart';

import '/models/cubit.dart';
import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class ScoutingSlider extends StatefulWidget {
  const ScoutingSlider({
    super.key,
    required this.cubit,
    required this.min,
    required this.max,
    this.step = 1,
    this.title = '',
    this.subtitle = '',
    this.initial,
  })  : assert(max <= 100),
        assert(min >= -100),
        assert(step > 0),
        assert(max > min + step),
        assert(initial == null || (initial >= min && initial <= max));

  final Cubit<int> cubit;
  final int? initial;
  final int min, max, step;
  final String title, subtitle;

  @override
  State<ScoutingSlider> createState() => _ScoutingSliderState();
}

class _ScoutingSliderState extends State<ScoutingSlider> {
  @override
  void initState() {
    widget.cubit.data = widget.initial ?? widget.min;
    super.initState();
  }

  Color get _sliderColor {
    return Color.lerp(
          ScoutingTheme.primaryVariant,
          ScoutingTheme.primary,
          widget.cubit.data / (widget.max - widget.min),
        ) ??
        ScoutingTheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    return widget.title.isEmpty && widget.subtitle.isEmpty
        ? _buildSlider()
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.title.isNotEmpty)
                ScoutingText.title(
                  widget.title,
                  textAlign: TextAlign.center,
                ).padSymmetric(horizontal: 32),
              _buildSlider(),
              if (widget.subtitle.isNotEmpty)
                ScoutingText.body(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                ).padSymmetric(horizontal: 32),
            ],
          );
  }

  Widget _buildSlider() {
    return padSymmetric(
      horizontal: 16,
      RepaintBoundary(
        child: Slider(
          value: widget.cubit.data.toDouble(),
          onChanged: (value) => setState(() {
            widget.cubit.data = value.toInt();
          }),
          thumbColor: _sliderColor,
          activeColor: _sliderColor,
          inactiveColor: ScoutingTheme.background3,
          divisions: (widget.max - widget.min) ~/ widget.step,
          label: widget.cubit.data.toString(),
          min: widget.min.toDouble(),
          max: widget.max.toDouble(),
        ),
      ),
    );
  }
}
