import 'dart:math' as math;

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamosad_analytics_app/src/app.dart';
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
      height: 30.0 * AnalyticsApp.size,
      getData: (team) => team.info.name,
      builder: (team) => FittedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0 * AnalyticsApp.size,
            vertical: 4.0 * AnalyticsApp.size,
          ),
          child: AnalyticsText.data(
            team.info.name,
            color: AnalyticsTheme.primary.withOpacity(0.8),
          ),
        ),
      ),
    ),
    'Score': DataEntry<double>(
      height: 30.0 * AnalyticsApp.size,
      getData: (team) => team.summary.score.average,
    ),
    'Auto Score': DataEntry<double>(
      height: 30.0 * AnalyticsApp.size,
      getData: (team) => team.auto.score.average,
    ),
    'Teleop Score': DataEntry<double>(
      height: 30.0 * AnalyticsApp.size,
      getData: (team) => team.teleop.score.average,
    ),
    'Endgame Score': DataEntry<double>(
      height: 30.0 * AnalyticsApp.size,
      getData: (team) => team.endgame.score.average,
    ),
    'Auto Drops': DataEntry<double>(
      height: 30.0 * AnalyticsApp.size,
      getData: (team) => team.auto.dropoffs.totalDropoffs.average,
    ),
    'Teleop Drops': DataEntry<double>(
      height: 30.0 * AnalyticsApp.size,
      getData: (team) => team.teleop.dropoffs.totalDropoffs.average,
    ),
    'Endgame Drops': DataEntry<double>(
      height: 30.0 * AnalyticsApp.size,
      getData: (team) => team.endgame.dropoffs.totalDropoffs.average,
    ),
    'Cones Drops': DataEntry<double>(
      height: 30.0 * AnalyticsApp.size,
      getData: (team) => team.summary.dropoffs.pieces.cones.average,
    ),
    'Cubes Drops': DataEntry<double>(
      height: 30.0 * AnalyticsApp.size,
      getData: (team) => team.summary.dropoffs.pieces.cubes.average,
    ),
    'Mobility Rate': DataEntry<double>(
      height: 30.0 * AnalyticsApp.size,
      getData: (team) => team.auto.leftCommunity.trueRate * 100.0,
    ),
    'Auto Engaged': DataEntry<double>(
      height: 30.0 * AnalyticsApp.size,
      getData: (team) => team.auto.climb.states.engagedRate * 100.0,
    ),
    'Auto Docked': DataEntry<double>(
      height: 30.0 * AnalyticsApp.size,
      getData: (team) => team.auto.climb.states.engagedRate * 100.0,
    ),
    'Endagme Engaged': DataEntry<double>(
      height: 30.0 * AnalyticsApp.size,
      getData: (team) => team.endgame.climb.states.engagedRate * 100.0,
    ),
    'Endagme Docked': DataEntry<double>(
      height: 30.0 * AnalyticsApp.size,
      getData: (team) => team.endgame.climb.states.dockedRate * 100.0,
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
          final query = _searchQuery.toLowerCase();

          if (query.contains(' ')) {
            final queries = query.split(' ');

            if (queries.first == 'team') {
              return team.info.number.toString().contains(queries.second);
            }

            return team.info.number.toString().contains(queries.first) &&
                team.info.name.toLowerCase().contains(
                      queries.skip(1).joinToString(separator: ' '),
                    );
          }

          return team.info.number.toString().contains(query) ||
              team.info.name.toLowerCase().contains(query);
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
      padding: EdgeInsets.all(20.0 * AnalyticsApp.size),
      child: Column(
        children: [
          _buildTitle(),
          SizedBox(height: 10.0 * AnalyticsApp.size),
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
              height: 50.0 * AnalyticsApp.size,
              child: AnalyticsContainer(
                child: TeamSearchBar(
                  onSubmitted: (query) => setState(() {
                    _searchQuery = query;
                  }),
                  suggestions: ref
                      .read(analytisDataProvider)
                      .teamsByNumber
                      .toTeamNumbers(),
                  currentQuery: _searchQuery,
                  hintText: 'Search for a team...',
                  searchIconColor: AnalyticsTheme.primary,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0 * AnalyticsApp.size),
          Expanded(
            flex: 30,
            child: Container(
              height: 50.0 * AnalyticsApp.size,
              decoration: BoxDecoration(
                color: AnalyticsTheme.background2,
                borderRadius: BorderRadius.circular(5.0 * AnalyticsApp.size),
              ),
              child: _buildSortByMenu(),
            ),
          ),
          SizedBox(width: 10.0 * AnalyticsApp.size),
          AnalyticsContainer(
            height: 50.0 * AnalyticsApp.size,
            width: 50.0 * AnalyticsApp.size,
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
          SizedBox(width: 10.0 * AnalyticsApp.size),
          Expanded(
            flex: 13,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  AnalyticsTheme.background2,
                ),
                fixedSize: MaterialStateProperty.all(
                  Size.fromHeight(50.0 * AnalyticsApp.size),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0 * AnalyticsApp.size),
            child: Icon(
              Icons.sort_rounded,
              size: 32.0 * AnalyticsApp.size,
              color: AnalyticsTheme.primary,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8.0 * AnalyticsApp.size),
              child: DropdownButton<String>(
                dropdownColor: AnalyticsTheme.background2,
                style: AnalyticsTheme.dataTitleTextStyle.copyWith(
                  color: AnalyticsTheme.foreground2,
                ),
                borderRadius: BorderRadius.circular(10.0 * AnalyticsApp.size),
                focusColor: AnalyticsTheme.background2,
                isExpanded: true,
                underline: const SizedBox.shrink(),
                value: _sortByKey,
                iconSize: 32.0 * AnalyticsApp.size,
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
          height: 50.0 * AnalyticsApp.size,
          child: Row(
            children: [
              _buildSelectRowsButton(context),
              SizedBox(width: 10.0 * AnalyticsApp.size),
              AnalyticsContainer(
                alignment: Alignment.center,
                width: 110.0 * AnalyticsApp.size,
                height: 50.0 * AnalyticsApp.size,
                child: AnalyticsText.data('Team'),
              ),
              SizedBox(width: 10.0 * AnalyticsApp.size),
              Expanded(child: _buildColumnTitles(teamsEntries)),
            ],
          ),
        ),
        SizedBox(height: 10.0 * AnalyticsApp.size),
        Expanded(
          child: Row(
            children: [
              _buildRowTitles(teamsEntries),
              SizedBox(width: 10.0 * AnalyticsApp.size),
              Expanded(child: _buildTable(teamsEntries)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectRowsButton(BuildContext context) => AnalyticsContainer(
        child: AnalyticsContainer(
          width: 50.0 * AnalyticsApp.size,
          height: 50.0 * AnalyticsApp.size,
          child: IconButton(
            icon: Icon(
              Icons.add_chart_rounded,
              size: 32.0 * AnalyticsApp.size,
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
                cancelText: Text(
                  'CANCEL',
                  style: AnalyticsTheme.dataSubtitleTextStyle.copyWith(
                    color: AnalyticsTheme.foreground2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                confirmText: Text(
                  'CONFIRM',
                  style: AnalyticsTheme.dataSubtitleTextStyle.copyWith(
                    color: AnalyticsTheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                searchable: true,
                searchHint: 'Search...',
                searchHintStyle: AnalyticsTheme.dataSubtitleTextStyle.copyWith(
                  color: AnalyticsTheme.foreground2,
                ),
                searchTextStyle: AnalyticsTheme.dataSubtitleTextStyle.copyWith(
                  color: AnalyticsTheme.foreground2,
                ),
                searchIcon: Icon(
                  Icons.search_rounded,
                  size: 28.0 * AnalyticsApp.size,
                  color: AnalyticsTheme.foreground2,
                ),
                closeSearchIcon: Icon(
                  Icons.clear_rounded,
                  size: 28.0 * AnalyticsApp.size,
                  color: AnalyticsTheme.foreground2,
                ),
                separateSelectedItems: true,
                height: 600.0 * AnalyticsApp.size,
                width: 500.0 * AnalyticsApp.size,
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
          padding: EdgeInsets.symmetric(horizontal: 5.0 * AnalyticsApp.size),
          child: ListView.separated(
            controller: _columnsTitlesScrollController,
            itemCount: teamsEntries.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              height: 50.0 * AnalyticsApp.size,
              alignment: Alignment.center,
              width: teamsEntries[index].width,
              child: AnalyticsText.data(
                  teamsEntries[index].team.info.number.toString()),
            ),
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 1.5 * AnalyticsApp.size,
              ),
              child: Container(
                width: 2.0 * AnalyticsApp.size,
                decoration: BoxDecoration(
                  color: AnalyticsTheme.foreground2,
                  borderRadius: BorderRadius.circular(1.0 * AnalyticsApp.size),
                ),
                margin: EdgeInsets.symmetric(vertical: 7.5 * AnalyticsApp.size),
              ),
            ),
          ),
        ),
      );

  Widget _buildHorizontalSeperator() => Container(
        height: 2.0 * AnalyticsApp.size,
        decoration: BoxDecoration(
          color: AnalyticsTheme.foreground2,
          borderRadius: BorderRadius.circular(1.0 * AnalyticsApp.size),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10.0 * AnalyticsApp.size),
      );

  Widget _buildRowTitles(List<TeamEntry> teamsEntries) => AnalyticsContainer(
        width: 170.0 * AnalyticsApp.size,
        child: ListView.separated(
          controller: _rowsTitlesScrollController,
          itemCount: _dataRows.length,
          itemBuilder: (context, index) => Container(
            height: TeamsPage.dataEntries[_dataRows[index]]!.height +
                14.0 * AnalyticsApp.size,
            alignment: Alignment.center,
            child: FittedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 6.0 * AnalyticsApp.size,
                  horizontal: 12.0 * AnalyticsApp.size,
                ),
                child: AnalyticsText.dataTitle(
                  _dataRows[index],
                  color: AnalyticsTheme.foreground1.withOpacity(0.8),
                ),
              ),
            ),
          ),
          separatorBuilder: (context, index) => _buildHorizontalSeperator(),
        ),
      );

  Widget _buildTable(List<TeamEntry> teamsEntries) => AnalyticsContainer(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.5 * AnalyticsApp.size,
            vertical: 5.0 * AnalyticsApp.size,
          ),
          child: ListView.builder(
            controller: _tableScrollController,
            scrollDirection: Axis.horizontal,
            itemCount: teamsEntries.length,
            itemBuilder: (context, teamIndex) => Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 2.5 * AnalyticsApp.size),
              child: AnalyticsContainer(
                color: AnalyticsTheme.background1,
                width: teamsEntries[teamIndex].width,
                alignment: Alignment.topCenter,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0 * AnalyticsApp.size),
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
                      padding: EdgeInsets.symmetric(
                          vertical: 6.0 * AnalyticsApp.size),
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
    return (100.0 + math.max(name.length - 7, 0) * 10.0) * AnalyticsApp.size;
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0 * AnalyticsApp.size,
                      vertical: 4.0 * AnalyticsApp.size,
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
