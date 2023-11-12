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
    this.onlyNumbers = false,
    this.onlyNames = false,
    this.errorHint,
  });

  final Cubit<String?> cubit;
  final String? errorHint;
  final String hint;
  final bool onlyNumbers, onlyNames;
  final String title;

  @override
  State<ScoutingTextField> createState() => _ScoutingTextFieldState();
}

class _ScoutingTextFieldState extends State<ScoutingTextField> {
  final _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _namesValidator = RegExp(r'^[a-zA-Z -]+');
  var _hasErrors = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      String hint = widget.hint.isNotEmpty
          ? (widget.hint.endsWith('...')
              ? widget.hint.toLowerCase().substring(0, widget.hint.length - 3)
              : widget.hint.toLowerCase())
          : 'enter some text';
      return widget.errorHint ?? 'Please $hint.';
    }

    if (widget.onlyNumbers) {
      if (int.tryParse(value) == null) return 'Only numbers are allowed.';
    }

    if (widget.onlyNames) {
      if (!_namesValidator.hasMatch(value)) {
        return 'Names should only contain English letters.';
      }
      if (value.length > 30) {
        return 'Name should be shorter than 30 characters.';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return padSymmetric(
      horizontal: 32,
      Form(
        key: _formKey,
        child: TextFormField(
          focusNode: _focusNode,
          keyboardType: widget.onlyNumbers ? TextInputType.number : TextInputType.text,
          validator: _validateInput,
          initialValue: widget.cubit.data,
          onChanged: (value) => setState(() {
            _hasErrors = !_formKey.currentState!.validate();
            widget.cubit.data = value;
          }),
          style: ScoutingTheme.bodyStyle,
          textDirection:
              intl.Bidi.estimateDirectionOfText(widget.cubit.data ?? '') == intl.TextDirection.RTL
                  ? TextDirection.rtl
                  : TextDirection.ltr,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: ScoutingTheme.bodyStyle.copyWith(
              color: ScoutingTheme.foreground2,
            ),
            labelText: widget.title,
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
}
