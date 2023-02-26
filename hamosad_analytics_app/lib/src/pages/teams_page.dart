import 'dart:math' as math;

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/database.dart';
import 'package:hamosad_analytics_app/src/models.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class TeamsPage extends ConsumerStatefulWidget {
  const TeamsPage({Key? key}) : super(key: key);

  static const String defaultSortKey = 'Name';
  static final List<String> defaultTeamEntreis = dataEntries.keys.toList();
  static final Map<String, DataEntry> dataEntries = {
    'Name': DataEntry<String>(
        height: 30.0,
        getData: (team) => team.info.name,
        builder: (team) => FittedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: AnalyticsText.data(
                  team.info.name,
                  color: AnalyticsTheme.primary.withOpacity(0.8),
                ),
              ),
            )),
    'Win Rate': DataEntry<double>(
      height: 35.0,
      getData: (team) => team.summary.winRate,
      builder: (team) => AnalyticsDataWinRate(
        won: team.summary.won,
        lost: team.summary.lost,
        inContainer: false,
      ),
    ),
    'Avg Score': DataEntry<double>(
      height: 30.0,
      getData: (team) => team.summary.score.average,
    ),
    'Avg Auto Cones Drop': DataEntry<double>(
      height: 30.0,
      getData: (team) => team.auto.dropoffs.pieces.cones.average,
    ),
    'Avg Tele Cones Pick': DataEntry<double>(
      height: 30.0,
      getData: (team) => team.teleop.pickups.pieces.cones.average,
    ),
    'Avg Total Cones Pick': DataEntry<double>(
      height: 30.0,
      getData: (team) => team.summary.pickups.pieces.cones.average,
    ),
    'Avg Endg Score': DataEntry<double>(
      height: 30.0,
      getData: (team) => team.endgame.score.average,
    ),
  };

  @override
  ConsumerState<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends ConsumerState<TeamsPage> {
  final LinkedScrollControllerGroup _horizontalScrollController =
          LinkedScrollControllerGroup(),
      _verticalScrollController = LinkedScrollControllerGroup();
  late final ScrollController _columnsTitlesScrollController =
          _horizontalScrollController.addAndGet(),
      _tableScrollController = _horizontalScrollController.addAndGet(),
      _rowsTitlesScrollController = _verticalScrollController.addAndGet();
  late final List<ScrollController> _tableEntriesControllers;
  late final List<Team> _teamsData;

  String _searchQuery = '';
  String _sortByKey = TeamsPage.defaultSortKey;
  bool _isSortingDescending = true;
  List<String> _dataRows = TeamsPage.defaultTeamEntreis;

  void _clearFilters() => setState(() {
        _searchQuery = '';
        _sortByKey = TeamsPage.defaultSortKey;
        _isSortingDescending = true;
        _dataRows = TeamsPage.defaultTeamEntreis;
      });

  List<TeamEntry> _getTeamsEntries() {
    List<TeamEntry> teams = _teamsData
        .where((team) {
          String query = _searchQuery.toLowerCase();
          return team.info.name.toLowerCase().contains(query) ||
              team.info.number.toString().contains(query);
        })
        .map((team) => TeamEntry(team))
        .toList();

    getDataFromTeam(team) => TeamsPage.dataEntries[_sortByKey]!.getData(team);
    teams.sort((a, b) {
      dynamic dataA = getDataFromTeam(a.team), dataB = getDataFromTeam(b.team);
      if (_isSortingDescending) {
        return Comparable.compare(dataB, dataA);
      } else {
        return Comparable.compare(dataA, dataB);
      }
    });

    return teams;
  }

  @override
  void initState() {
    _teamsData = ref.read(analytisDataProvider).teamsByNumber;
    _tableEntriesControllers = List.generate(
      _teamsData.length,
      (index) => _verticalScrollController.addAndGet(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          _buildTitle(),
          const SizedBox(height: 10.0),
          Expanded(child: _buildBody(context)),
        ],
      ),
    );
  }

  Widget _buildTitle() => Row(
        children: [
          Expanded(
            flex: 30,
            child: SizedBox(
              height: 50.0,
              child: SearchBar(
                onSubmitted: (query) => setState(() {
                  _searchQuery = query;
                }),
                currentQuery: _searchQuery,
                hintText: 'Search for a team...',
                searchIconColor: AnalyticsTheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            flex: 30,
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                color: AnalyticsTheme.background2,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: _buildSortByMenu(),
            ),
          ),
          const SizedBox(width: 10.0),
          AnalyticsContainer(
            height: 50.0,
            width: 50.0,
            child: IconButton(
              splashRadius: 1.0,
              onPressed: () => setState(() {
                _isSortingDescending = !_isSortingDescending;
              }),
              icon: RotatedBox(
                quarterTurns: 3,
                child: AnimatedSwitcher(
                  duration: 250.milliseconds,
                  switchInCurve: Curves.easeInOutCirc,
                  switchOutCurve: Curves.easeInOutCirc,
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  child: SvgPicture.asset(
                    _isSortingDescending
                        ? 'assets/svg/sort_descending.svg'
                        : 'assets/svg/sort_ascending.svg',
                    key: ValueKey<bool>(_isSortingDescending),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            flex: 13,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  AnalyticsTheme.background2,
                ),
                fixedSize: MaterialStateProperty.all(
                  const Size.fromHeight(50.0),
                ),
              ),
              onPressed: _clearFilters,
              child: AnalyticsText.dataTitle(
                'Clear Filters',
                color: AnalyticsTheme.primary,
              ),
            ),
          ),
        ],
      );

  Widget _buildSortByMenu() => Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(
              Icons.sort_rounded,
              size: 32.0,
              color: AnalyticsTheme.primary,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: DropdownButton<String>(
                dropdownColor: AnalyticsTheme.background2,
                style: AnalyticsTheme.dataTitleTextStyle.copyWith(
                  color: AnalyticsTheme.foreground2,
                ),
                borderRadius: BorderRadius.circular(10.0),
                focusColor: AnalyticsTheme.background2,
                isExpanded: true,
                underline: const SizedBox.shrink(),
                value: _sortByKey,
                iconSize: 32.0,
                iconEnabledColor: AnalyticsTheme.primary,
                items: _dataRows
                    .map((sortKey) => DropdownMenuItem<String>(
                          value: sortKey,
                          child: Text(sortKey),
                        ))
                    .toList(),
                onChanged: (String? newKey) => setState(() {
                  _sortByKey = newKey ?? 'Rank';
                }),
              ),
            ),
          ),
        ],
      );

  Widget _buildBody(BuildContext context) {
    List<TeamEntry> teamsEntries = _getTeamsEntries();
    return Column(
      children: [
        SizedBox(
          height: 50.0,
          child: Row(
            children: [
              _buildSelectRowsButton(context),
              const SizedBox(width: 10.0),
              AnalyticsContainer(
                alignment: Alignment.center,
                width: 110.0,
                height: 50.0,
                child: AnalyticsText.data('Team'),
              ),
              const SizedBox(width: 10.0),
              Expanded(child: _buildColumnTitles(teamsEntries)),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Expanded(
          child: Row(
            children: [
              _buildRowTitles(teamsEntries),
              const SizedBox(width: 10.0),
              Expanded(child: _buildTable(teamsEntries)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectRowsButton(BuildContext context) => AnalyticsContainer(
        child: AnalyticsContainer(
          width: 50.0,
          height: 50.0,
          child: IconButton(
            icon: const Icon(
              Icons.add_chart_rounded,
              size: 32.0,
              color: AnalyticsTheme.primary,
            ),
            splashRadius: 1.0,
            onPressed: () => showDialog(
              context: context,
              builder: (context) => MultiSelectDialog(
                backgroundColor: AnalyticsTheme.background2,
                checkColor: AnalyticsTheme.foreground1,
                selectedColor: AnalyticsTheme.primaryVariant,
                unselectedColor: AnalyticsTheme.foreground2,
                itemsTextStyle: AnalyticsTheme.dataTitleTextStyle.copyWith(
                  color: AnalyticsTheme.foreground2,
                ),
                selectedItemsTextStyle:
                    AnalyticsTheme.dataTitleTextStyle.copyWith(
                  color: AnalyticsTheme.foreground2,
                ),
                title: Text(
                  'Select data rows:',
                  textAlign: TextAlign.center,
                  style: AnalyticsTheme.dataTitleTextStyle.copyWith(
                    fontSize: 26.0,
                    color: AnalyticsTheme.foreground2,
                  ),
                ),
                cancelText: AnalyticsText.dataSubtitle(
                  'CANCEL',
                  color: AnalyticsTheme.foreground2,
                  fontWeight: FontWeight.w500,
                ),
                confirmText: AnalyticsText.dataSubtitle(
                  'CONFIRM',
                  color: AnalyticsTheme.primary,
                  fontWeight: FontWeight.w700,
                ),
                searchable: true,
                searchHint: 'Search...',
                searchHintStyle: AnalyticsTheme.dataSubtitleTextStyle.copyWith(
                  color: AnalyticsTheme.foreground2,
                ),
                searchTextStyle: AnalyticsTheme.dataSubtitleTextStyle.copyWith(
                  color: AnalyticsTheme.foreground2,
                ),
                searchIcon: const Icon(
                  Icons.search_rounded,
                  size: 28.0,
                  color: AnalyticsTheme.foreground2,
                ),
                closeSearchIcon: const Icon(
                  Icons.clear_rounded,
                  size: 28.0,
                  color: AnalyticsTheme.foreground2,
                ),
                separateSelectedItems: true,
                height: 600.0,
                width: 500.0,
                onConfirm: (selectedData) => setState(() {
                  _dataRows = selectedData;
                  if (!_dataRows.contains(_sortByKey)) {
                    if (_dataRows.contains(TeamsPage.defaultSortKey) ||
                        _dataRows.isEmpty) {
                      _sortByKey = TeamsPage.defaultSortKey;
                    } else {
                      _sortByKey = _dataRows.first;
                    }
                  }
                }),
                items: TeamsPage.defaultTeamEntreis
                    .map((data) => MultiSelectItem(data, data))
                    .toList(),
                initialValue: _dataRows,
              ),
            ),
          ),
        ),
      );

  Widget _buildColumnTitles(List<TeamEntry> teamsEntries) => AnalyticsContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: ListView.separated(
            controller: _columnsTitlesScrollController,
            itemCount: teamsEntries.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              height: 50.0,
              alignment: Alignment.center,
              width: teamsEntries[index].width,
              child: AnalyticsText.data(
                  teamsEntries[index].team.info.number.toString()),
            ),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.5),
              child: Container(
                width: 2.0,
                decoration: BoxDecoration(
                  color: AnalyticsTheme.foreground2,
                  borderRadius: BorderRadius.circular(1.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 7.5),
              ),
            ),
          ),
        ),
      );

  Widget _buildHorizontalSeperator() => Container(
        height: 2.0,
        decoration: BoxDecoration(
          color: AnalyticsTheme.foreground2,
          borderRadius: BorderRadius.circular(1.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
      );

  Widget _buildRowTitles(List<TeamEntry> teamsEntries) => AnalyticsContainer(
        width: 170.0,
        child: ListView.separated(
          controller: _rowsTitlesScrollController,
          itemCount: _dataRows.length,
          itemBuilder: (context, index) => Container(
            height: TeamsPage.dataEntries[_dataRows[index]]!.height + 14.0,
            alignment: Alignment.center,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                child: AnalyticsText.dataTitle(_dataRows[index]),
              ),
            ),
          ),
          separatorBuilder: (context, index) => _buildHorizontalSeperator(),
        ),
      );

  Widget _buildTable(List<TeamEntry> teamsEntries) => AnalyticsContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 5.0),
          child: ListView.builder(
            controller: _tableScrollController,
            scrollDirection: Axis.horizontal,
            itemCount: teamsEntries.length,
            itemBuilder: (context, teamIndex) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.5),
              child: AnalyticsContainer(
                color: AnalyticsTheme.background1,
                width: teamsEntries[teamIndex].width,
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ListView.separated(
                    controller: _tableEntriesControllers[teamIndex],
                    itemCount: _dataRows.length,
                    itemBuilder: (context, entryIndex) {
                      DataEntry entry =
                          TeamsPage.dataEntries[_dataRows[entryIndex]]!;
                      return Container(
                        height: entry.height + 1.0,
                        alignment: Alignment.center,
                        child: entry.builder(teamsEntries[teamIndex].team),
                      );
                    },
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: _buildHorizontalSeperator(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class TeamEntry {
  TeamEntry(this.team) : width = _calculateWidth(team.info.name);

  final Team team;
  final double width;

  static double _calculateWidth(String name) {
    return 100.0 + math.max(name.length - 7, 0) * 10.0;
  }
}

class DataEntry<T> {
  DataEntry({
    required this.height,
    required this.getData,
    Widget Function(Team)? builder,
  }) : builder = builder ??
            ((team) => FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: AnalyticsText.data(
                      dataToString(
                        getData(team),
                      ),
                      color: AnalyticsTheme.foreground1,
                    ),
                  ),
                ));

  final double height;
  final T Function(Team) getData;
  final Widget Function(Team) builder;

  static String dataToString(data) {
    if (data is num) {
      return data.toStringAsPrecision(3);
    }
    return data.toString();
  }
}
