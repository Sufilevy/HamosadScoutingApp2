import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/other/cubit.dart';
import 'package:xcontext/material.dart';

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

  static ScoutingToggleButton fromJSON({
    required Map<String, dynamic> json,
    required Cubit<bool> cubit,
    double size = 1,
  }) {
    assert(json.containsKey('title'));

    return ScoutingToggleButton(
      cubit: cubit,
      size: size,
      title: json['title'],
    );
  }

  @override
  State<ScoutingToggleButton> createState() => _ScoutingToggleButtonState();
}

class _ScoutingToggleButtonState extends State<ScoutingToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48 * widget.size),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Transform.scale(
            scale: 1.35 * widget.size,
            child: Checkbox(
              value: widget.cubit.data,
              onChanged: (value) => setState(
                () => widget.cubit.data = value ?? !widget.cubit.data,
              ),
              side: BorderSide(
                color: context.theme.textTheme.bodyLarge?.color ?? Colors.black,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              activeColor: context.theme.toggleableActiveColor,
              checkColor: context.theme.textTheme.bodyLarge?.color,
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12 * widget.size),
              child: TextButton(
                onPressed: () => setState(
                  () => widget.cubit.data = !widget.cubit.data,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8 * widget.size),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.theme.textTheme.bodyLarge?.color,
                      fontSize: 24 * widget.size,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
