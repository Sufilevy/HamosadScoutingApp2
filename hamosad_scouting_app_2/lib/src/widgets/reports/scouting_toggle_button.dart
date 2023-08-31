import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/theme.dart';
import 'package:hamosad_scouting_app_2/src/widgets/generic/scouting_text.dart';

class ScoutingToggleButton extends StatefulWidget {
  const ScoutingToggleButton({
    Key? key,
    required this.cubit,
    required this.title,
  }) : super(key: key);

  final Cubit<bool> cubit;
  final String title;

  @override
  State<ScoutingToggleButton> createState() => _ScoutingToggleButtonState();
}

class _ScoutingToggleButtonState extends State<ScoutingToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 54.0 * ScoutingTheme.appSizeRatio),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.75 * ScoutingTheme.appSizeRatio,
            child: Checkbox(
              value: widget.cubit.data,
              onChanged: (value) => setState(
                () => widget.cubit.data = value ?? !widget.cubit.data,
              ),
              side: const BorderSide(
                color: ScoutingTheme.foreground2,
                width: 2.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              activeColor: ScoutingTheme.primary,
              checkColor: ScoutingTheme.background1,
            ),
          ),
          Flexible(
            child: TextButton(
              onPressed: () => setState(
                () => widget.cubit.data = !widget.cubit.data,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 4.0 * ScoutingTheme.appSizeRatio,
                  horizontal: 2.0 * ScoutingTheme.appSizeRatio,
                ),
                child: ScoutingText.subtitle(
                  widget.title,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
