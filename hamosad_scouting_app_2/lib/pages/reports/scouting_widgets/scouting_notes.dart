import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '/models/cubit.dart';
import '/theme.dart';
import '/widgets/paddings.dart';

class ScoutingNotes extends StatefulWidget {
  const ScoutingNotes({
    Key? key,
    required this.cubit,
    this.title = 'Notes',
    this.hint = 'Enter your notes...',
  }) : super(key: key);

  final Cubit<String> cubit;
  final String title, hint;

  @override
  State<ScoutingNotes> createState() => _ScoutingNotesState();
}

class _ScoutingNotesState extends State<ScoutingNotes> {
  Widget _buildTextField(BuildContext context) {
    final normalBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: ScoutingTheme.background3,
        width: 2.0 * ScoutingTheme.appSizeRatio,
      ),
    );

    final selectedBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: ScoutingTheme.primaryVariant,
        width: 3.5 * ScoutingTheme.appSizeRatio,
      ),
    );

    final errorBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: ScoutingTheme.error,
        width: 3.5 * ScoutingTheme.appSizeRatio,
      ),
    );

    return TextField(
      onChanged: (String value) => setState(() => widget.cubit.data = value),
      minLines: 3,
      maxLines: null,
      style: ScoutingTheme.bodyStyle,
      textDirection: intl.Bidi.estimateDirectionOfText(widget.cubit.data) == intl.TextDirection.RTL
          ? TextDirection.rtl
          : TextDirection.ltr,
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.title,
        hintStyle: ScoutingTheme.bodyStyle.copyWith(
          color: ScoutingTheme.foreground2,
        ),
        labelStyle: ScoutingTheme.bodyStyle.copyWith(
          color: ScoutingTheme.foreground2,
        ),
        errorStyle: ScoutingTheme.bodyStyle.copyWith(
          fontSize: 16.0,
          color: ScoutingTheme.error,
        ),
        errorBorder: normalBorder,
        border: normalBorder,
        enabledBorder: normalBorder,
        focusedBorder: selectedBorder,
        focusedErrorBorder: errorBorder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return padSymmetric(
      horizontal: 56.0,
      widget.title.isNotEmpty
          ? Column(children: [_buildTextField(context)])
          : _buildTextField(context),
    );
  }
}
