import 'package:another_flushbar/flushbar.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '/services/database/analytics_database.dart';
import '/services/providers/selected_districts_provider.dart';
import '/services/utilities.dart';
import '/theme.dart';
import '/widgets/analytics.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class SelectDistrictsDialog extends ConsumerStatefulWidget {
  const SelectDistrictsDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectDistrictsDialogState();
}

class _SelectDistrictsDialogState extends ConsumerState<SelectDistrictsDialog> {
  Districts _selectedDistricts = {};

  @override
  void initState() {
    // Clone the list of selected districts instead of assigning to avoid pointing to the same list
    _selectedDistricts = Districts.from(ref.read(selectedDistrictsProvider).value ?? {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return padSymmetric(
      vertical: 100,
      horizontal: (context.screenSize.width - 520 * AnalyticsTheme.appSizeRatio) / 2,
      Dialog(
        child: FutureBuilder(
          future: AnalyticsDatabase.allDistricts(),
          builder: (context, snapshot) => snapshot.whenData(
            (allDistricts) => padSymmetric(
              horizontal: 16,
              vertical: 24,
              Column(
                children: [
                  navigationTitleText('Select Districts'),
                  Gap(16 * AnalyticsTheme.appSizeRatio),
                  Expanded(
                    child: _districtsButtons(allDistricts.toSet()),
                  ),
                  Gap(16 * AnalyticsTheme.appSizeRatio),
                  _confirmButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _districtsButtons(Districts allDistricts) {
    final districts = allDistricts.toList();
    return ListView.builder(
      itemCount: districts.length,
      itemBuilder: (context, index) => _districtButton(
        districts[index],
        _selectedDistricts.contains(districts[index]),
      ).padBottom(10),
    );
  }

  Widget _districtButton(String district, bool isSelected) {
    onPressed() => setState(
          () {
            if (isSelected) {
              _selectedDistricts.remove(district);
            } else {
              _selectedDistricts.add(district);
            }
          },
        );

    return ListTile(
      onTap: onPressed,
      title: dataTitleText(
        district
            .replaceFirst('district', 'District ')
            .replaceFirst('-', ' (')
            .replaceFirst('dcmp', 'DCMP')
            .push(')'),
      ),
      trailing: Switch(
        value: isSelected,
        onChanged: null,
        inactiveThumbColor: isSelected ? AnalyticsTheme.background3 : AnalyticsTheme.foreground2,
        activeColor: isSelected ? AnalyticsTheme.background3 : AnalyticsTheme.foreground2,
        inactiveTrackColor: isSelected ? AnalyticsTheme.primary : AnalyticsTheme.background2,
        activeTrackColor: isSelected ? AnalyticsTheme.primary : AnalyticsTheme.background2,
      ),
    );
  }

  Widget _confirmButton() {
    return TextButton(
      onPressed: () {
        if (_selectedDistricts.isEmpty) {
          _showAtLeastOneDistrictWarning();
        } else {
          ref.read(selectedDistrictsProvider.notifier).setDistricts(_selectedDistricts);
          Navigator.pop(context);
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AnalyticsTheme.background1),
      ),
      child: navigationText('OK', color: AnalyticsTheme.primary)
          .padSymmetric(horizontal: 12, vertical: 6),
    );
  }

  void _showAtLeastOneDistrictWarning() {
    Flushbar(
      messageText: navigationTitleText('Please select at least 1 district.'),
      icon: const FaIcon(
        FontAwesomeIcons.triangleExclamation,
        color: AnalyticsTheme.warning,
      ).padLeft(30),
      backgroundColor: AnalyticsTheme.background2,
      margin: EdgeInsets.only(bottom: 20 * AnalyticsTheme.appSizeRatio),
      maxWidth: 500 * AnalyticsTheme.appSizeRatio,
      borderRadius: BorderRadius.circular(5),
      duration: 2.seconds,
      animationDuration: 400.milliseconds,
    ).show(context);
  }
}
