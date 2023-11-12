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
  });

  final Cubit<bool> cubit;
  final String title;

  @override
  State<ScoutingToggleButton> createState() => _ScoutingToggleButtonState();
}

class _ScoutingToggleButtonState extends State<ScoutingToggleButton> {
  @override
  Widget build(BuildContext context) {
    return padSymmetric(
      horizontal: 54,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Transform.scale(
            scale: 1.75 * ScoutingTheme.appSizeRatio,
            child: Checkbox(
              activeColor: ScoutingTheme.primary,
              checkColor: ScoutingTheme.background1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
              side: const BorderSide(color: ScoutingTheme.foreground2, width: 2),
              value: widget.cubit.data,
              onChanged: (value) => setState(() {
                widget.cubit.data = value ?? !widget.cubit.data;
              }),
            ),
          ),
          Flexible(
            child: TextButton(
              onPressed: () => setState(() {
                widget.cubit.data = !widget.cubit.data;
              }),
              child: ScoutingText.subtitle(widget.title).padSymmetric(horizontal: 2, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}
