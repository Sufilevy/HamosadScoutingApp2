import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:hamosad_analytics_app/services/utilities.dart';

import '/theme.dart';
import '/widgets/analytics.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class SelectReportView extends ConsumerStatefulWidget {
  const SelectReportView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectReportViewState();
}

class _SelectReportViewState extends ConsumerState<SelectReportView> {
  final _filterTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return padSymmetric(
      vertical: 16,
      horizontal: 16,
      ListView(
        children: [
          _filterRow(),
          SectionDivider(
            topPadding: 16 * AnalyticsTheme.appSizeRatio,
            bottomPadding: 16 * AnalyticsTheme.appSizeRatio,
          ),
        ],
      ),
    );
  }

  Widget _filterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _filterTypeDropdown(),
        Gap(24 * AnalyticsTheme.appSizeRatio),
        dataTitleText('is', fontWeight: FontWeight.bold),
        Gap(24 * AnalyticsTheme.appSizeRatio),
        DropdownMenu<String>(
          width: context.screenSize.width / 2,
          dropdownMenuEntries: const [],
        ),
      ],
    );
  }

  Widget _filterTypeDropdown() {
    return DropdownMenu<_FilterType>(
      controller: _filterTypeController,
      textStyle: AnalyticsTheme.dataTitleStyle.copyWith(
        fontSize: 18 * AnalyticsTheme.appSizeRatio,
      ),
      width: context.screenSize.width / 4,
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 12 * AnalyticsTheme.appSizeRatio,
        ),
      ),
      label: const Text('Filter'),
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: _FilterType.team,
          label: 'Team',
          trailingIcon: FaIcon(
            FontAwesomeIcons.peopleGroup,
            size: 20 * AnalyticsTheme.appSizeRatio,
            color: AnalyticsTheme.primaryVariant,
          ),
        ),
        DropdownMenuEntry(
          value: _FilterType.game,
          label: 'Game',
          trailingIcon: FaIcon(
            FontAwesomeIcons.gamepad,
            size: 20 * AnalyticsTheme.appSizeRatio,
            color: AnalyticsTheme.primaryVariant,
          ),
        ),
        DropdownMenuEntry(
          value: _FilterType.scouter,
          label: 'Scouter',
          trailingIcon: FaIcon(
            FontAwesomeIcons.userPen,
            size: 20 * AnalyticsTheme.appSizeRatio,
            color: AnalyticsTheme.primaryVariant,
          ),
        ),
      ],
    );
  }
}

enum _FilterType {
  team,
  game,
  scouter,
}
