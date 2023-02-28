import 'package:easy_search_bar/easy_search_bar.dart';
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
              AnalyticsTwoRateChip(
                first: team.summary.won,
                second: team.summary.lost,
              ),
              AnalyticsTwoRateChip.pieces(
                cones: team.summary.dropoffs.pieces.cones.average,
                cubes: team.summary.dropoffs.pieces.cubes.average,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsStatChip.fromStat(
                team.auto.score,
                title: 'Auto Score',
              ),
              AnalyticsStatChip.fromStat(
                team.teleop.score,
                title: 'Teleop Score',
              ),
              AnalyticsStatChip.fromStat(
                team.endgame.score,
                title: 'Endgame Score',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsStatChip.fromStat(
                team.auto.dropoffs.totalDropoffs,
                title: 'Auto\nDropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.teleop.dropoffs.totalDropoffs,
                title: 'Teleop\nDropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.endgame.dropoffs.totalDropoffs,
                title: 'Endgame\nDropoffs',
              ),
            ],
          ),
        ],
        AnalyticsTab.auto: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsStatChip.fromStat(
                team.auto.dropoffs.allGrids.rows[0],
                title: 'Top Row\nDropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.auto.dropoffs.allGrids.rows[1],
                title: 'Middle Row\nDropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.auto.dropoffs.allGrids.rows[2],
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
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0 * AnalyticsApp.size),
                    child: AnalyticsText.dataSubtitle('Mobility'),
                  ),
                  AnalyticsTwoRateChip(
                    first: team.auto.leftCommunity.trueRate,
                    second: team.auto.leftCommunity.falseRate,
                  ),
                ],
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
                team.teleop.dropoffs.allGrids.rows[0],
                title: 'Top Row\nDropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.teleop.dropoffs.allGrids.rows[1],
                title: 'Middle Row\nDropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.teleop.dropoffs.allGrids.rows[2],
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
              ),
            ],
          ),
        ],
        AnalyticsTab.endgame: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnalyticsStatChip.fromStat(
                team.endgame.dropoffs.allGrids.rows[0],
                title: 'Top Row\nDropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.endgame.dropoffs.allGrids.rows[1],
                title: 'Middle Row\nDropoffs',
              ),
              AnalyticsStatChip.fromStat(
                team.endgame.dropoffs.allGrids.rows[2],
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
              ),
              AnalyticsClimbsStatChip(
                team.endgame.climb.states,
                dockedByOther: true,
              ),
            ],
          ),
        ],
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
    Widget title = AnalyticsText.navigation('Search for a team:');
    if (TeamDetailsPage.team != null) {
      final team = TeamDetailsPage.team!;
      title = AnalyticsPageTitle(
        title: 'Team ${team.info.number}',
        subtitle: '${team.info.name}, ${team.info.location}',
      );
    }

    return Column(
      children: [
        _buildTeamSearch(title),
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

  Widget _buildTeamSearch(Widget title) => SizedBox(
        height: 65.0 * AnalyticsApp.size,
        child: EasySearchBar(
          onSearch: (_) {},
          onSuggestionTap: (data) => setState(() {
            final teamNumber = int.parse(data.split('-').first.trim());
            TeamDetailsPage.team = _data.teamsWithNumber[teamNumber];
            _setTabs();
          }),
          suggestions: _data.teamsByNumber.toTeamNumbers(),
          title: title,
          elevation: 2.0,
          appBarHeight: 65.0 * AnalyticsApp.size,
          iconTheme: IconThemeData(
            color: AnalyticsTheme.primary,
            size: 34.0 * AnalyticsApp.size,
          ),
          searchBackIconTheme: IconThemeData(
            size: 28.0 * AnalyticsApp.size,
            color: AnalyticsTheme.primary,
          ),
          suggestionBuilder: (data) => Padding(
            padding: EdgeInsets.all(8.0 * AnalyticsApp.size),
            child: Center(
              child: AnalyticsText.dataTitle(data),
            ),
          ),
          suggestionBackgroundColor: AnalyticsTheme.background2,
          backgroundColor: AnalyticsTheme.background2,
          suggestionsElevation: 8.0,
          openOverlayOnSearch: true,
          searchBackgroundColor: AnalyticsTheme.background2,
          searchCursorColor: AnalyticsTheme.primary,
          searchTextStyle: AnalyticsTheme.navigationTextStyle,
          searchHintStyle: AnalyticsTheme.navigationTextStyle.copyWith(
            color: AnalyticsTheme.foreground2,
          ),
          searchHintText: 'Enter a team\'s name or number...',
        ),
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
