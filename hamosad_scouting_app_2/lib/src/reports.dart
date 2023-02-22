import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';

Widget gameReport(BuildContext context, double size) {
  return ScoutingReportPage(
    size: size,
    title: 'Game Report',
    tabs: [
      ScoutingReportTab(
        size: size,
        title: 'Info',
        children: [
          ScoutingCounter(
            cubit: reportDataProvider(context).gameReport.teleopHubMissed,
            min: 0,
            max: 100,
            step: 1,
            title: 'Teleop Hub Missed',
            initial: 0,
            size: size,
          ),
          ScoutingImage(
            title: 'This is an image',
            url:
                'https://www.manchesterdigital.com/storage/13256/0_ZQ9Xa7CINFVMA95w.png',
            scale: 1.0,
          ),
          ScoutingSlider(
            cubit: Cubit(0),
            min: 1,
            max: 5,
            step: 1,
            title: 'This is a  slider',
            subtitle: 'This is the subtitle',
            initial: 1,
            size: size,
          ),
          ScoutingTeamNumber(
            cubit: Cubit(''),
            teams: const [
              '1000',
              '2000',
              '3000',
              '4000',
              '5000',
              '6000',
            ],
            size: size,
          ),
          ScoutingTextField(
            cubit: Cubit(''),
            title: 'Name',
            hint: 'Enter your name...',
            errorHint: 'Please enter your name.',
            size: size,
          ),
          ScoutingText.text(
            'This is some text!',
            fontSize: 20,
          ),
          ScoutingToggleButton(
            cubit: Cubit(false),
            title: 'This is a really really extremly very very long title',
            size: size,
          ),
          ScoutingSlider(
            cubit: Cubit(0),
            min: 1,
            max: 5,
            step: 1,
            title: 'This is a  slider',
            subtitle: 'This is the subtitle',
            initial: 1,
            size: size,
          ),
          ScoutingCounter(
            cubit: Cubit(0),
            min: 0,
            max: 100,
            step: 1,
            title: 'This is a looooong counter',
            initial: 0,
            size: size,
          ),
        ],
      ),
      ScoutingReportTab(
        size: size,
        title: 'Heyoo',
        children: [
          ScoutingText.text('hello'),
        ],
      ),
    ],
  );
}

Widget pitReport(BuildContext context, double size) {
  return ScoutingReportPage(
    size: size,
    title: 'Pit Report',
    tabs: [
      ScoutingReportTab(
        size: size,
        title: 'Hi',
        children: [
          ScoutingText.text('hello'),
        ],
      ),
    ],
  );
}
