import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/json/cubit.dart';

class ScoutingTextField extends StatefulWidget {
  final Cubit<String> textCubit;
  final double size;
  final String hint;
  final bool onlyNumbers;

  const ScoutingTextField({
    Key? key,
    required this.textCubit,
    this.size = 1.0,
    this.hint = '',
    this.onlyNumbers = false,
  }) : super(key: key);

  static ScoutingTextField fromJSON({
    required Map<String, dynamic> json,
    required Cubit<String> textCubit,
    required double size,
  }) {
    return ScoutingTextField(
      textCubit: textCubit,
      size: size,
      hint: json['hint'] ?? '',
      onlyNumbers: json['onlyNumbers'] ?? false,
    );
  }

  @override
  State<ScoutingTextField> createState() => _ScoutingTextFieldState();
}

class _ScoutingTextFieldState extends State<ScoutingTextField> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please ${widget.hint.toLowerCase()}.';
    }
    if (widget.onlyNumbers) {
      if (int.tryParse(value) == null) return 'Only numbers allowed.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0 * widget.size),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          keyboardType:
              widget.onlyNumbers ? TextInputType.number : TextInputType.text,
          validator: validateInput,
          onChanged: (value) => _formKey.currentState!.validate(),
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: widget.hint,
          ),
        ),
      ),
    );
  }
}
