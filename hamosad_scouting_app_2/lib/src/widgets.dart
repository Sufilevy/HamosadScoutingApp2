import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';

export 'widgets/other/circle_painter.dart';
export 'widgets/pages/scouting_home_page.dart';
export 'widgets/pages/scouting_report_page.dart';
export 'widgets/pages/scouting_report_tab.dart';
export 'widgets/scouting_widgets/scouting_alert_dialog.dart';
export 'widgets/scouting_widgets/scouting_climbs.dart';
export 'widgets/scouting_widgets/scouting_counter.dart';
export 'widgets/scouting_widgets/scouting_dropoffs.dart';
export 'widgets/scouting_widgets/scouting_icon_button.dart';
export 'widgets/scouting_widgets/scouting_image.dart';
export 'widgets/scouting_widgets/scouting_match_and_team.dart';
export 'widgets/scouting_widgets/scouting_notes.dart';
export 'widgets/scouting_widgets/scouting_slider.dart';
export 'widgets/scouting_widgets/scouting_switches.dart';
export 'widgets/scouting_widgets/scouting_text.dart';
export 'widgets/scouting_widgets/scouting_text_field.dart';
export 'widgets/scouting_widgets/scouting_toggle_button.dart';

void showWarningSnackBar(BuildContext context, double size, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.warning_rounded,
            color: ScoutingTheme.warning,
            size: 36.0 * size,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0 * size),
            child: ScoutingText.subtitle(
              title,
            ),
          ),
        ],
      ),
      backgroundColor: ScoutingTheme.background2,
      duration: 2.seconds,
    ),
  );
}
