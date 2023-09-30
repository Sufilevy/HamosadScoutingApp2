import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/models/cubit.dart';
import 'package:hamosad_scouting_app_2/theme.dart';
import 'package:hamosad_scouting_app_2/widgets/paddings.dart';
import 'package:intl/intl.dart' as intl;

class ScoutingTextField extends StatefulWidget {
  const ScoutingTextField({
    Key? key,
    required this.cubit,
    this.hint = '',
    this.title = '',
    this.onlyNumbers = false,
    this.onlyNames = false,
    this.errorHint,
  }) : super(key: key);

  final Cubit<String?> cubit;
  final String? errorHint;
  final String hint;
  final bool onlyNumbers, onlyNames;
  final String title;

  @override
  State<ScoutingTextField> createState() => _ScoutingTextFieldState();
}

class _ScoutingTextFieldState extends State<ScoutingTextField> {
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _hasErrors = false;
  final RegExp _namesValidator = RegExp(r'^[a-zA-Z -]{1,30}$');

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
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return padSymmetric(
      horizontal: 32.0,
      Form(
        key: _formKey,
        child: TextFormField(
          focusNode: _focusNode,
          keyboardType: widget.onlyNumbers ? TextInputType.number : TextInputType.text,
          validator: _validateInput,
          initialValue: widget.cubit.data,
          onChanged: (value) => setState(
            () {
              _hasErrors = !_formKey.currentState!.validate();
              widget.cubit.data = value;
            },
          ),
          style: ScoutingTheme.textStyle,
          textDirection:
              intl.Bidi.estimateDirectionOfText(widget.cubit.data ?? '') == intl.TextDirection.RTL
                  ? TextDirection.rtl
                  : TextDirection.ltr,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: ScoutingTheme.textStyle.copyWith(
              color: ScoutingTheme.foreground2,
            ),
            labelText: widget.title,
            labelStyle: ScoutingTheme.textStyle.copyWith(
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
                width: 2.0 * ScoutingTheme.appSizeRatio,
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
                width: 2.0 * ScoutingTheme.appSizeRatio,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ScoutingTheme.background3,
                width: 2.0 * ScoutingTheme.appSizeRatio,
              ),
            ),
            errorStyle: ScoutingTheme.textStyle.copyWith(
              fontSize: 16.0,
              color: ScoutingTheme.error,
            ),
          ),
        ),
      ),
    );
  }
}
