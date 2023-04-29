import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/theme.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';

export 'pages/scouting_home_page.dart';
export 'pages/scouting_report_page.dart';
export 'pages/scouting_report_tab.dart';
export 'widgets/generic/circle_painter.dart';
export 'widgets/generic/scouting_alert_dialog.dart';
export 'widgets/generic/scouting_icon_button.dart';
export 'widgets/generic/scouting_image.dart';
export 'widgets/generic/scouting_text.dart';
export 'widgets/reports/generic/scouting_counter.dart';
export 'widgets/reports/generic/scouting_match_and_team.dart';
export 'widgets/reports/generic/scouting_notes.dart';
export 'widgets/reports/generic/scouting_slider.dart';
export 'widgets/reports/generic/scouting_switch.dart';
export 'widgets/reports/generic/scouting_text_field.dart';
export 'widgets/reports/generic/scouting_toggle_button.dart';

void showWarningSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.warning_rounded,
            color: ScoutingTheme.warning,
            size: 36.0 * ScoutingTheme.appSizeRatio,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0 * ScoutingTheme.appSizeRatio),
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
