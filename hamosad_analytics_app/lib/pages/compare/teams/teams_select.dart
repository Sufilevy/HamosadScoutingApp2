import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';

import '/theme.dart';
import '/widgets/paddings.dart';

class TeamsSelect extends StatelessWidget {
  const TeamsSelect({
    super.key,
    required this.teams,
    required this.onSelectionChange,
    this.selectedTeams,
  });

  final List<String> teams;
  final List<String>? selectedTeams;
  final void Function(List<String> teams) onSelectionChange;

  @override
  Widget build(BuildContext context) {
    return SmartSelect<String>.multiple(
      title: 'Select Teams',
      placeholder: '',
      choiceItems: teams.map((team) => S2Choice<String>(title: team, value: team)).toList(),
      selectedChoice: _selectedChoice,
      onChange: (value) {
        onSelectionChange(
          value.choice?.map((selection) => selection.value).toList() ?? [],
        );
      },
      choiceType: S2ChoiceType.switches,
      modalConfig: const S2ModalConfig(
        type: S2ModalType.bottomSheet,
        useFilter: true,
        filterHint: 'Search teams...',
        filterAuto: true,
        enableDrag: false,
      ),
      builder: S2MultiBuilder(
        choiceSecondary: (context, _, choice) => _teamColorAvatar(
          TeamInfo.fromNumber(choice.value).color,
        ),
        modalFilterToggle: _modalFilterToggle,
        modalHeader: _modalHeader,
        tile: (context, state) => S2Tile.fromState(
          state,
          hideValue: true,
          loadingText: '',
          trailing: const Icon(Icons.keyboard_arrow_right_rounded),
        ),
      ),
    );
  }

  List<S2Choice<String>>? get _selectedChoice =>
      selectedTeams?.map((team) => S2Choice<String>(title: team, value: team)).toList();

  Widget _teamColorAvatar(Color color) {
    return pad(
      right: 10,
      top: 5,
      left: 12,
      Container(
        width: 16 * AnalyticsTheme.appSizeRatio,
        height: 16 * AnalyticsTheme.appSizeRatio,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _modalFilterToggle(BuildContext context, S2MultiState<String> state) {
    final clearSelection = IconButton(
      icon: const Icon(Icons.remove_done_rounded),
      onPressed: () => state.selection?.clear(),
    );

    final searchIcon = !state.filter!.activated
        ? IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => state.filter!.show(context),
          )
        : IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => state.filter!.hide(context),
          );

    return Row(
      children: <Widget>[
        clearSelection.padRight(8),
        searchIcon.padRight(12),
      ],
    );
  }

  Widget _modalHeader(BuildContext context, S2MultiState<String> state) {
    final bool isFiltering = state.filter?.activated == true;

    final leading = IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: isFiltering
          ? () => Navigator.popUntil(context, (route) => route.isFirst)
          : () => Navigator.maybePop(context),
    );

    return AppBar(
      leading: leading,
      title: isFiltering
          ? state.modalFilter
          : Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                state.modalTitle,
                state.modalError,
              ],
            ),
      actions: state.modalActions,
    );
  }
}
