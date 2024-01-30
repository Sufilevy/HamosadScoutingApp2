import 'package:flutter/material.dart';

import '/models/cubit.dart';
import 'text_field.dart';

class ScoutingNotes extends StatelessWidget {
  const ScoutingNotes({super.key, required this.cubit});

  final Cubit<String> cubit;

  @override
  Widget build(BuildContext context) {
    return ScoutingTextField(
      cubit: cubit,
      title: 'Notes',
      hint: 'Enter your notes...',
      canBeEmpty: true,
      lines: 3,
    );
  }
}
