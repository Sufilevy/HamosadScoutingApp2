import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/other/cubit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:xcontext/material.dart';

class ScoutingNotes extends StatefulWidget {
  final Cubit<String> cubit;
  final double size;
  final String title;

  const ScoutingNotes({
    Key? key,
    required this.cubit,
    this.size = 1.0,
    this.title = '',
  }) : super(key: key);

  @override
  State<ScoutingNotes> createState() => _ScoutingNotesState();
}

class _ScoutingNotesState extends State<ScoutingNotes> {
  Widget _textField(BuildContext context) => TextField(
        onChanged: (String value) => setState(() => widget.cubit.data = value),
        minLines: 3,
        maxLines: null,
        style: TextStyle(
          fontSize: context.theme.textTheme.bodyMedium?.fontSize,
          color: context.theme.textTheme.labelSmall?.color,
        ),
        textDirection: intl.Bidi.estimateDirectionOfText(widget.cubit.data) ==
                intl.TextDirection.RTL
            ? TextDirection.rtl
            : TextDirection.ltr,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (widget.title.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 56 * widget.size),
        child: Column(
          children: [
            Text(
              widget.title,
              style: context.theme.textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8 * widget.size),
            _textField(context),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 56 * widget.size),
        child: _textField(context),
      );
    }
  }
}
