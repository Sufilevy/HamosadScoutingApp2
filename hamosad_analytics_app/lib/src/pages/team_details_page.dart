import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamosad_analytics_app/src/app.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/database/analytics_data.dart';
import 'package:hamosad_analytics_app/src/models.dart';
import 'package:hamosad_analytics_app/src/pages.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

class TeamDetailsPage extends ConsumerStatefulWidget {
  const TeamDetailsPage({Key? key}) : super(key: key);

  static Team? team;

  @override
  ConsumerState<TeamDetailsPage> createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends ConsumerState<TeamDetailsPage> {
  late final AnalyticsData _data;
  late Map<AnalyticsTab, List<Widget>> _tabs;
  final Cubit<AnalyticsTab> _currentTab = Cubit(AnalyticsTab.general);

  void _setTabs() {
    if (TeamDetailsPage.team != null) {
      final team = TeamDetailsPage.team!;
      _tabs = {
        AnalyticsTab.general: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsStatChip.fromStat(
                team.summary.score,
                title: 'Total Score',
              ),
              AnalyticsDefenceStatChip(
                team.summary.defenceIndex,
                title: 'Defence',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsTwoRateChip.pieces(
                cones: team.summary.dropoffs.pieces.cones.average,
                cubes: team.summary.dropoffs.pieces.cubes.average,
                isPercent: false,
                title: 'Dropoffs',
              ),
              AnalyticsDurationsStatChip(
                team.summary.dropoffs.duration,
                title: 'Dropoffs',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsStatChip.fromStat(
                team.teleop.dropoffs.grids.rows[2] &
                    team.endgame.dropoffs.grids.rows[2],
                title: 'Top Row\nDropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.teleop.dropoffs.grids.rows[1] &
                    team.endgame.dropoffs.grids.rows[1],
                title: 'Middle Row\nDropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.teleop.dropoffs.grids.rows[0] &
                    team.endgame.dropoffs.grids.rows[0],
                title: 'Bottom Row\nDropoffs',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsTwoRateChip(
                first: team.summary.pickups.loadingZoneRate,
                second: team.summary.pickups.floorRate,
                isPercent: true,
                firstColor: AnalyticsTheme.primary,
                secondColor: AnalyticsTheme.primary.withOpacity(0.8),
                title: '< Load zone\nFloor >',
              ),
              AnalyticsDurationsStatChip(
                team.summary.pickups.duration,
                title: 'Pickups',
              ),
            ],
          ),
        ],
        AnalyticsTab.auto: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsStatChip.fromStat(
                team.auto.dropoffs.grids.rows[2],
                title: 'Top Row\nDropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.auto.dropoffs.grids.rows[1],
                title: 'Middle Row\nDropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.auto.dropoffs.grids.rows[0],
                title: 'Bottom Row\nDropoffs',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsTwoRateChip.pieces(
                cones: team.auto.dropoffs.pieces.cones.average,
                cubes: team.auto.dropoffs.pieces.cubes.average,
                isPercent: false,
                title: 'Dropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.auto.pickups.floor.pieces,
                title: 'Pickups',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsTwoRateChip(
                first: team.auto.leftCommunity.trueRate,
                second: team.auto.leftCommunity.falseRate,
                title: 'Mobility',
              ),
              AnalyticsClimbsStatChip(
                team.auto.climb.states,
                dockedByOther: false,
              ),
            ],
          ),
        ],
        AnalyticsTab.teleop: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsStatChip.fromStat(
                team.teleop.dropoffs.grids.rows[2],
                title: 'Top Row\nDropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.teleop.dropoffs.grids.rows[1],
                title: 'Middle Row\nDropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.teleop.dropoffs.grids.rows[0],
                title: 'Bottom Row\nDropoffs',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsTwoRateChip.pieces(
                cones: team.teleop.dropoffs.pieces.cones.average,
                cubes: team.teleop.dropoffs.pieces.cubes.average,
                isPercent: false,
                title: 'Dropoffs',
              ),
              AnalyticsDurationsStatChip(
                team.teleop.dropoffs.duration,
                title: 'Dropoffs',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsDurationsStatChip(
                team.teleop.pickups.duration,
                title: 'Pickups',
              ),
              AnalyticsStatChip.fromStat(
                team.teleop.chargeStationPasses,
                title: 'Charge Station Passes',
              ),
            ],
          ),
        ],
        AnalyticsTab.endgame: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsStatChip.fromStat(
                team.endgame.dropoffs.grids.rows[2],
                title: 'Top Row\nDropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.endgame.dropoffs.grids.rows[1],
                title: 'Middle Row\nDropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.endgame.dropoffs.grids.rows[0],
                title: 'Bottom Row\nDropoffs',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsTwoRateChip.pieces(
                cones: team.endgame.dropoffs.pieces.cones.average,
                cubes: team.endgame.dropoffs.pieces.cubes.average,
                isPercent: false,
                title: 'Dropoffs',
              ),
              AnalyticsDurationsStatChip(
                team.endgame.dropoffs.duration,
                title: 'Dropoffs',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsDurationsStatChip(
                team.endgame.pickups.duration,
                title: 'Pickups',
              ),
              AnalyticsStatChip.fromStat(
                team.endgame.chargeStationPasses,
                title: 'Charge Station Passes',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsClimbsStatChip(
                team.endgame.climb.states,
                dockedByOther: true,
              ),
              AnalyticsDurationsStatChip(
                team.endgame.climb.duration,
                title: 'Climb',
              ),
            ],
          )
        ],
        AnalyticsTab.notes: [
          AnalyticsNotes(team),
        ]
      };
    }
  }

  @override
  void initState() {
    _data = ref.read(analytisDataProvider);
    _setTabs();
    super.initState();
  }

  Widget _buildTitle() {
    var searchBarVisible = false;

    Widget title = AnalyticsText.navigation(
      'Search for a team:',
      color: AnalyticsTheme.foreground2,
    );
    if (TeamDetailsPage.team != null) {
      final team = TeamDetailsPage.team!;
      title = AnalyticsPageTitle(
        title: 'Team ${team.info.number}',
        subtitle: '${team.info.name}, ${team.info.location}',
      );
    }

    return Column(
      children: [
        AnalyticsContainer(
          padding: const EdgeInsets.all(10.0) * AnalyticsApp.size,
          child: SizedBox(
            height: 50.0 * AnalyticsApp.size,
            child: StatefulBuilder(
              builder: (context, setState) {
                return searchBarVisible
                    ? Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_rounded),
                            color: AnalyticsTheme.primary,
                            iconSize: 32.0 * AnalyticsApp.size,
                            onPressed: () => setState(() {
                              searchBarVisible = false;
                            }),
                          ),
                          Expanded(child: _buildTeamSearch()),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          title,
                          IconButton(
                            icon: const Icon(Icons.search_rounded),
                            color: AnalyticsTheme.primary,
                            iconSize: 32.0 * AnalyticsApp.size,
                            onPressed: () => setState(() {
                              searchBarVisible = true;
                            }),
                          ),
                        ],
                      );
              },
            ),
          ),
        ),
        if (TeamDetailsPage.team != null) ...[
          SizedBox(height: 25.0 * AnalyticsApp.size),
          AnalyticsTabsSelector(
            currentTabCubit: _currentTab,
            onTabSelected: () => setState(() {}),
          ),
        ],
      ],
    );
  }

  Widget _buildTeamSearch() => TeamSearchBar(
        hintText: 'Enter a team\'s name or number...',
        searchOnIconPressed: false,
        searchIconColor: AnalyticsTheme.primary,
        underlineBorder: true,
        suggestions: _data.teamsByNumber.toTeamNumbers(),
        onSubmitted: (query) => setState(() {
          final parts = query.split(' ');
          final teamNumber =
              int.parse(query.contains('Team') ? parts.second : parts.first);
          TeamDetailsPage.team = _data.teamsWithNumber[teamNumber];
          _setTabs();
        }),
      );

  Widget _buildBody() {
    if (TeamDetailsPage.team == null) {
      return Center(
        child: AnalyticsText.data('There is no selected team.'),
      );
    }

    return AnalyticsFadeSwitcher(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        key: ValueKey<AnalyticsTab>(_currentTab.data),
        onHorizontalDragEnd: (details) {
          final velocity = details.primaryVelocity ?? 0.0;

          // Swipe right - go one tab to the left
          if (velocity > 500.0) {
            if (_currentTab.data.index > 0) {
              setState(() {
                _currentTab.data =
                    AnalyticsTab.values[_currentTab.data.index - 1];
              });
            }
          }
          // Swipe left - go one tab to the right
          else if (velocity < -500.0) {
            if (_currentTab.data.index < AnalyticsTab.values.length - 1) {
              setState(() {
                _currentTab.data =
                    AnalyticsTab.values[_currentTab.data.index + 1];
              });
            }
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _tabs[_currentTab.data]!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnalyticsPage(
      title: _buildTitle(),
      body: _buildBody(),
    );
  }
}
