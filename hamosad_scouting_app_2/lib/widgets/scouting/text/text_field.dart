import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '/models/cubit.dart';
import '/theme.dart';
import '/widgets/paddings.dart';

class ScoutingTextField extends StatefulWidget {
  const ScoutingTextField({
    super.key,
    required this.cubit,
    this.hint = '',
    this.title = '',
    this.canBeEmpty = false,
    this.onlyNumbers = false,
    this.onlyNames = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.textDirection,
    this.errorHint,
  });

  final Cubit<String?> cubit;
  final String hint;
  final bool canBeEmpty, onlyNumbers, onlyNames;
  final String title;
  final int minLines, maxLines;
  final String? errorHint;
  final TextDirection? textDirection;

  @override
  State<ScoutingTextField> createState() => _ScoutingTextFieldState();
}

class _ScoutingTextFieldState extends State<ScoutingTextField> {
  final _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _hasErrors = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return padSymmetric(
      horizontal: 60,
      Form(
        key: _formKey,
        child: TextFormField(
          focusNode: _focusNode,
          textInputAction: widget.minLines > 1 ? TextInputAction.newline : TextInputAction.done,
          keyboardType: widget.onlyNumbers
              ? TextInputType.number
              : (widget.minLines > 1 ? TextInputType.multiline : TextInputType.text),
          validator: _validateInput,
          initialValue: widget.cubit.data,
          onChanged: (value) => setState(() {
            _hasErrors = !_formKey.currentState!.validate();
            widget.cubit.data = value;
          }),
          minLines: widget.minLines,
          maxLines: widget.minLines,
          style: ScoutingTheme.bodyStyle,
          textDirection: widget.textDirection ??
              (intl.Bidi.estimateDirectionOfText(widget.cubit.data ?? '') == intl.TextDirection.RTL
                  ? TextDirection.rtl
                  : TextDirection.ltr),
          decoration: InputDecoration(
            hintText: widget.hint,
            labelText: widget.title,
            floatingLabelAlignment:
                widget.textDirection == TextDirection.rtl ? FloatingLabelAlignment.center : null,
            floatingLabelBehavior:
                widget.textDirection == TextDirection.rtl ? FloatingLabelBehavior.always : null,
            hintTextDirection: widget.textDirection,
            alignLabelWithHint: true,
            hintStyle: ScoutingTheme.bodyStyle.copyWith(
              color: ScoutingTheme.foreground2,
            ),
            labelStyle: ScoutingTheme.bodyStyle.copyWith(
              color: _focusNode.hasFocus
                  ? (_hasErrors ? ScoutingTheme.error : ScoutingTheme.primary)
                  : ScoutingTheme.foreground2,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ScoutingTheme.primaryVariant,
                width: 3.5 * ScoutingTheme.appSizeRatio,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ScoutingTheme.background3,
                width: 2 * ScoutingTheme.appSizeRatio,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ScoutingTheme.error,
                width: 3.5 * ScoutingTheme.appSizeRatio,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: ScoutingTheme.background3,
                width: 2 * ScoutingTheme.appSizeRatio,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ScoutingTheme.background3,
                width: 2 * ScoutingTheme.appSizeRatio,
              ),
            ),
            errorStyle: ScoutingTheme.bodyStyle.copyWith(
              fontSize: 16,
              color: ScoutingTheme.error,
            ),
          ),
        ),
      ),
    );
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      if (widget.canBeEmpty) {
        return null;
      }

      String hint = widget.hint.isNotEmpty
          ? (widget.hint.endsWith('...')
              ? widget.hint.toLowerCase().substring(0, widget.hint.length - 3)
              : widget.hint.toLowerCase())
          : 'enter some text';
      return widget.errorHint ?? 'Please $hint.';
    }

    if (widget.onlyNumbers) {
      final asInt = int.tryParse(value);
      if (asInt == null || asInt.isNegative) return 'Only numbers are allowed.';
    }

    if (widget.onlyNames) {
      if (!value.characters.all((c) => c.isLowerCase || c.isUpperCase || c == ' ' || c == '-')) {
        return "Names should only contain English letters, '-' or ' '.";
      }
      if (value.length > 30) {
        return 'Name should be shorter than 30 characters.';
      }
      if (value.isBlank) {
        return 'Names should not be blank.';
      }
    }

    return null;
  }
}
