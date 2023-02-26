import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets/scouting_widgets/scouting_text.dart';

class ScoutingToggleButton extends StatefulWidget {
  final Cubit<bool> cubit;
  final double size;
  final String title;

  const ScoutingToggleButton({
    Key? key,
    required this.cubit,
    required this.title,
    this.size = 1,
  }) : super(key: key);

  @override
  State<ScoutingToggleButton> createState() => _ScoutingToggleButtonState();
}

class _ScoutingToggleButtonState extends State<ScoutingToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 54.0 * widget.size),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.75 * widget.size,
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
                  vertical: 4.0 * widget.size,
                  horizontal: 2.0 * widget.size,
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
