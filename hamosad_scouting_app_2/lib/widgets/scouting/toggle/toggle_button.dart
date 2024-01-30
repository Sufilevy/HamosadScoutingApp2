import 'package:flutter/material.dart';

import '/models/cubit.dart';
import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class ScoutingToggleButton extends StatefulWidget {
  const ScoutingToggleButton({
    super.key,
    required this.cubit,
    required this.title,
    this.onPressed,
  });

  final Cubit<bool> cubit;
  final String title;
  final VoidCallback? onPressed;

  @override
  State<ScoutingToggleButton> createState() => _ScoutingToggleButtonState();
}

class _ScoutingToggleButtonState extends State<ScoutingToggleButton> {
  @override
  Widget build(BuildContext context) {
    return padSymmetric(
      horizontal: 54,
      TextButton.icon(
        onPressed: () => setState(() {
          widget.cubit.data = !widget.cubit.data;
          widget.onPressed?.call();
        }),
        label: ScoutingText.subtitle(widget.title, fontWeight: FontWeight.w400).padRight(8),
        icon: Transform.scale(
          scale: 1.5 * ScoutingTheme.appSizeRatio,
          child: Checkbox(
            activeColor: ScoutingTheme.primary,
            checkColor: ScoutingTheme.background1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            side: BorderSide(color: ScoutingTheme.foreground2.withOpacity(0.8), width: 2),
            splashRadius: 0,
            value: widget.cubit.data,
            onChanged: (value) => setState(() {
              widget.cubit.data = value ?? !widget.cubit.data;
              widget.onPressed?.call();
            }),
          ),
        ),
        style: ButtonStyle(
          padding: MaterialStatePropertyAll(
            const EdgeInsets.fromLTRB(16, 24, 24, 24) * ScoutingTheme.appSizeRatio,
          ),
          backgroundColor: MaterialStatePropertyAll(
            ScoutingTheme.background2.withOpacity(0.75),
          ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
