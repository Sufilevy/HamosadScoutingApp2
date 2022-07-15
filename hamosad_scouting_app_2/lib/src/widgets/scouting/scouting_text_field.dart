import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/other/cubit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:xcontext/material.dart';

class ScoutingTextField extends StatefulWidget {
  final Cubit<String> cubit;
  final double size;
  final String hint;
  final bool onlyNumbers;
  final String? errorHint;

  const ScoutingTextField({
    Key? key,
    required this.cubit,
    this.size = 1,
    this.hint = '',
    this.onlyNumbers = false,
    this.errorHint,
  }) : super(key: key);

  static ScoutingTextField fromJSON({
    required Map<String, dynamic> json,
    required Cubit<String> textCubit,
    required double size,
  }) {
    return ScoutingTextField(
      cubit: textCubit,
      size: size,
      hint: json['hint'] ?? '',
      onlyNumbers: json['onlyNumbers'] ?? false,
    );
  }

  @override
  State<ScoutingTextField> createState() => _ScoutingTextFieldState();
}

class _ScoutingTextFieldState extends State<ScoutingTextField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return widget.errorHint ??
          'Please ${widget.hint.isNotEmpty ? widget.hint.toLowerCase() : 'enter some text'}.';
    }
    if (widget.onlyNumbers) {
      if (int.tryParse(value) == null) return 'Only numbers allowed.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32 * widget.size),
      child: Form(
        key: _formKey,
        child: TextFormField(
          focusNode: _focusNode,
          keyboardType:
              widget.onlyNumbers ? TextInputType.number : TextInputType.text,
          validator: validateInput,
          onChanged: (value) => setState(
            () {
              _formKey.currentState!.validate();
              widget.cubit.data = value;
            },
          ),
          style: TextStyle(
            fontSize: context.theme.textTheme.bodyLarge?.fontSize,
            color: context.theme.textTheme.labelSmall?.color,
          ),
          textDirection: intl.Bidi.estimateDirectionOfText(widget.cubit.data) ==
                  intl.TextDirection.RTL
              ? TextDirection.rtl
              : TextDirection.ltr,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            errorStyle: TextStyle(
              fontSize: context.theme.textTheme.bodyMedium?.fontSize,
            ),
            labelText: widget.hint,
            labelStyle: TextStyle(
              color: _focusNode.hasFocus
                  ? context.theme.textTheme.bodyLarge?.color
                  : context.theme.textTheme.labelSmall?.color,
            ),
          ),
        ),
      ),
    );
  }
}
