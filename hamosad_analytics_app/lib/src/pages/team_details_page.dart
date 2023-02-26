import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  late final Map<AnalyticsTab, List<Widget>> _tabs;
  final Cubit<AnalyticsTab> _currentTab = Cubit(AnalyticsTab.general);

  @override
  void initState() {
    _data = ref.read(analytisDataProvider);
    // print(_data.teamsByNumber.first);
    // TeamDetailsPage.team = _data.teamsByNumber.first;

    if (TeamDetailsPage.team != null) {
      final team = TeamDetailsPage.team!;
      _tabs = {
        AnalyticsTab.general: [
          Row(
            children: [
              AnalyticsStatChip.fromStat(
                team.summary.score,
                title: 'Total Score',
              ),
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
              AnalyticsDataWinRate(
                won: team.summary.won,
                lost: team.summary.lost,
              ),
            ],
          ),
          Row(
            children: [
              TeamDropoffsChart(dropoffs: team.summary.dropoffs),
            ],
          ),
        ],
        AnalyticsTab.auto: [
          const Text('Auto'),
        ],
        AnalyticsTab.teleop: [
          const Text('Teleop'),
        ],
        AnalyticsTab.endgame: [
          const Text('Endgame'),
        ],
      };
    }
    super.initState();
  }

  Widget _buildTitle() {
    if (TeamDetailsPage.team == null) {
      return Container();
    }

    final team = TeamDetailsPage.team!;
    return Column(
      children: [
        AnalyticsPageTitle(
          title: 'Team ${team.info.number}',
          subtitle: '${team.info.name}, ${team.info.location}',
        ),
        const SizedBox(height: 20.0),
        AnalyticsTabsSelector(
          currentTabCubit: _currentTab,
          onTabSelected: () => setState(() {}),
        ),
      ],
    );
  }

  Widget _buildTeamSearch() => EasySearchBar(
        title: Container(),
        onSearch: (team) => setState(() {
          print(team);
        }),
        openOverlayOnSearch: true,
        searchBackgroundColor: AnalyticsTheme.background2,
        searchCursorColor: AnalyticsTheme.primary,
        searchTextStyle: AnalyticsTheme.navigationTextStyle,
        searchHintStyle: AnalyticsTheme.navigationTextStyle.copyWith(
          color: AnalyticsTheme.foreground2,
        ),
        searchHintText: 'Enter a team\'s name or number...',
        suggestions: const [
          '1657 Hamosad',
          '1690 Orbit',
          '5135 Black Unicorns',
          '5951 MA',
          '3075 Ha-Dream',
        ],
        // _data.teamsByNumber.toTeamNumbers(),
      );

  Widget _buildBody() {
    if (TeamDetailsPage.team == null) {
      return _buildTeamSearch();
    }

    return Column(
      key: ValueKey<AnalyticsTab>(_currentTab.data),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _tabs[_currentTab.data]!,
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
