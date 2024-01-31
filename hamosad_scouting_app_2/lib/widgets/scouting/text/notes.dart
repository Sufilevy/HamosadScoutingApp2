import 'package:flutter/material.dart';

import '/models/cubit.dart';
import '/widgets/buttons.dart';
import 'text_field.dart';

class ScoutingNotes extends StatelessWidget {
  const ScoutingNotes({super.key, required this.cubit});

  final Cubit<String> cubit;

  @override
  Widget build(BuildContext context) {
    return InfoButton(
      widgetName: 'הערות',
      description: "פה תכתבו כל דבר מיוחד שקרה שרלוונטי לחלק הזה של המשחק.\n\n"
          "לדוגמה:\n"
          "חלק מהרובוט נשבר, הרובוט לא זז, הרובוט נוסע לאט/קטוע, "
          "הרובוט נתקע בהכל, הרובוט משחק ממש טוב/ממש רע...",
      buttonAlignment: Alignment.centerLeft,
      child: ScoutingTextField(
        cubit: cubit,
        hint: 'הערות...',
        textDirection: TextDirection.rtl,
        canBeEmpty: true,
        minLines: 3,
        maxLines: 5,
      ),
    );
  }
}
