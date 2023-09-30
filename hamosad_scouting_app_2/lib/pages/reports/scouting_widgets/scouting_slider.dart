import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/models/cubit.dart';
import 'package:hamosad_scouting_app_2/theme.dart';
import 'package:hamosad_scouting_app_2/widgets/paddings.dart';
import 'package:hamosad_scouting_app_2/widgets/text.dart';

class ScoutingSlider extends StatefulWidget {
  const ScoutingSlider({
    Key? key,
    required this.cubit,
    required this.min,
    required this.max,
    required this.step,
    this.title = '',
    this.subtitle = '',
    this.initial,
  })  : assert(max <= 100),
        assert(min >= -100),
        assert(step > 0),
        assert(max > min + step),
        assert(initial == null || (initial >= min && initial <= max)),
        super(key: key);

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
    if (widget.initial != null) {
      widget.cubit.data = widget.initial!;
    } else {
      widget.cubit.data = ((widget.min + widget.max) / 2).ceil();
    }
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
                ).padSymmetric(horizontal: 32.0),
              _buildSlider(),
              if (widget.subtitle.isNotEmpty)
                ScoutingText.text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                ).padSymmetric(horizontal: 32.0),
            ],
          );
  }
}
