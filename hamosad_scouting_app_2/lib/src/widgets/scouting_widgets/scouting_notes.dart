import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:intl/intl.dart' as intl;

class ScoutingNotes extends StatefulWidget {
  final Cubit<String> cubit;
  final double size;
  final String title, hint;

  const ScoutingNotes({
    Key? key,
    required this.cubit,
    this.size = 1.0,
    this.title = 'Notes',
    this.hint = 'Enter your notes...',
  }) : super(key: key);

  @override
  State<ScoutingNotes> createState() => _ScoutingNotesState();
}

class _ScoutingNotesState extends State<ScoutingNotes> {
  Widget _buildTextField(BuildContext context) => TextField(
        onChanged: (String value) => setState(() => widget.cubit.data = value),
        minLines: 3,
        maxLines: null,
        style: ScoutingTheme.textStyle,
        textDirection: intl.Bidi.estimateDirectionOfText(widget.cubit.data) ==
                intl.TextDirection.RTL
            ? TextDirection.rtl
            : TextDirection.ltr,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: ScoutingTheme.textStyle.copyWith(
            color: ScoutingTheme.foreground2,
          ),
          labelText: widget.title,
          labelStyle: ScoutingTheme.textStyle.copyWith(
            color: ScoutingTheme.foreground2,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ScoutingTheme.primaryVariant,
              width: 3.5 * widget.size,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ScoutingTheme.background3,
              width: 2.0 * widget.size,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ScoutingTheme.error,
              width: 3.5 * widget.size,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ScoutingTheme.background3,
              width: 2.0 * widget.size,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ScoutingTheme.background3,
              width: 2.0 * widget.size,
            ),
          ),
          errorStyle: ScoutingTheme.textStyle.copyWith(
            fontSize: 16.0,
            color: ScoutingTheme.error,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (widget.title.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 56.0 * widget.size),
        child: Column(
          children: [
            _buildTextField(context),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 56.0 * widget.size),
        child: _buildTextField(context),
      );
    }
  }
}
