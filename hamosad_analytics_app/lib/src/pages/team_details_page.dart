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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [],
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
          const SizedBox(height: 25.0),
          AnalyticsTabsSelector(
            currentTabCubit: _currentTab,
            onTabSelected: () => setState(() {}),
          ),
        ],
      ],
    );
  }

  Widget _buildTeamSearch(Widget title) => SizedBox(
        height: 55.0,
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
          appBarHeight: 55.0,
          iconTheme: const IconThemeData(color: AnalyticsTheme.primary),
          searchBackIconTheme:
              const IconThemeData(color: AnalyticsTheme.primary),
          suggestionBuilder: (data) => Padding(
            padding: const EdgeInsets.all(8.0),
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

    return Column(
      key: ValueKey<AnalyticsTab>(_currentTab.data),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
