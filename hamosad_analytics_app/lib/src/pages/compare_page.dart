import 'package:carousel_slider/carousel_slider.dart';
import 'package:dartx/dartx.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamosad_analytics_app/src/app.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/database.dart';
import 'package:hamosad_analytics_app/src/models.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

enum AnalyticsChartType { line, spider }

class CompareTeamsPage extends ConsumerStatefulWidget {
  const CompareTeamsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CompareTeamsPage> createState() => _ComparePageState();
}

class _ComparePageState extends ConsumerState<CompareTeamsPage> {
  late final AnalyticsData _data;
  final List<int> _selectedTeams = [];
  AnalyticsChartType _chartType = AnalyticsChartType.line;

  @override
  void initState() {
    _data = ref.read(analytisDataProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0) * AnalyticsApp.size,
      child: Column(
        children: [
          _buildTitle(),
          SizedBox(height: 10.0 * AnalyticsApp.size),
          Expanded(
            child: ComparePageCharts(
              teams: _selectedTeams,
              chartType: _chartType,
              data: _data,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() => AnalyticsContainer(
        height: 70.0 * AnalyticsApp.size,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const EmptyExpanded(flex: 1),
            Expanded(
              flex: 20,
              child: TeamSearchBar(
                onSubmitted: (query) => setState(() {
                  final parts = query.split(' ');
                  final teamNumber = int.parse(
                      query.contains('Team ') ? parts.second : parts.first);
                  _selectedTeams.add(teamNumber);
                }),
                searchOnIconPressed: false,
                suggestions: _data.teamsByNumber
                    .filterNot(
                        (team) => _selectedTeams.contains(team.info.number))
                    .toList()
                    .toTeamNumbers(),
                hintText: 'Search for a team...',
                searchIconColor: AnalyticsTheme.primary,
              ),
            ),
            const EmptyExpanded(flex: 1),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () => setState(() {
                  _selectedTeams.clear();
                }),
                color: AnalyticsTheme.primary,
                disabledColor: AnalyticsTheme.primary,
                splashRadius: 1.0,
                iconSize: 32.0 * AnalyticsApp.size,
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.cancel_rounded),
              ),
            ),
            const EmptyExpanded(flex: 1),
            Expanded(
              flex: 40,
              child: ListView.builder(
                itemBuilder: (context, index) => _buildTeamChip(
                  _selectedTeams[index],
                ),
                itemCount: _selectedTeams.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const EmptyExpanded(flex: 1),
            Expanded(
              flex: 4,
              child: _buildChartTypeSwitch(),
            ),
            const EmptyExpanded(flex: 1),
          ],
        ),
      );

  Widget _buildTeamChip(int teamNumber) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 15.0) *
            AnalyticsApp.size,
        child: Container(
            width: 130.0 * AnalyticsApp.size,
            height: 40.0 * AnalyticsApp.size,
            decoration: BoxDecoration(
              color: AnalyticsTheme.teamNumberToColor[teamNumber],
              borderRadius: BorderRadius.circular(25.0) * AnalyticsApp.size,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.0 * AnalyticsApp.size,
                  ),
                  child: SizedBox(
                    child: AnalyticsText.logo(
                      teamNumber.toString(),
                      color: AnalyticsTheme.foreground1,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() {
                    _selectedTeams.remove(teamNumber);
                  }),
                  color: AnalyticsTheme.foreground1,
                  disabledColor: AnalyticsTheme.foreground1,
                  splashRadius: 1.0,
                  iconSize: 28.0 * AnalyticsApp.size,
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.cancel_rounded),
                ),
              ],
            )),
      );

  Widget _buildChartTypeSwitch() => Transform.scale(
        scale: 1.75 * AnalyticsApp.size,
        child: Switch(
          value: _chartType == AnalyticsChartType.line,
          thumbColor: MaterialStateProperty.all(AnalyticsTheme.primary),
          trackColor: MaterialStateProperty.all(AnalyticsTheme.background1),
          inactiveThumbColor: AnalyticsTheme.primary,
          inactiveTrackColor: AnalyticsTheme.background1,
          thumbIcon: MaterialStateProperty.all(
            Icon(
              _chartType == AnalyticsChartType.line
                  ? Icons.trending_up_rounded
                  : Icons.donut_large_rounded,
              size: 14.0 * AnalyticsApp.size,
              opticalSize: 14.0 * AnalyticsApp.size,
              color: AnalyticsTheme.background2,
            ),
          ),
          onChanged: (value) => setState(() {
            _chartType =
                value ? AnalyticsChartType.line : AnalyticsChartType.spider;
          }),
        ),
      );
}

class ComparePageCharts extends StatefulWidget {
  const ComparePageCharts({
    super.key,
    required this.teams,
    required this.chartType,
    required this.data,
  });

  final List<int> teams;
  final AnalyticsChartType chartType;
  final AnalyticsData data;

  @override
  State<ComparePageCharts> createState() => _ComparePageChartsState();
}

class _ComparePageChartsState extends State<ComparePageCharts> {
  final CarouselController _carouselController = CarouselController();
  int _currentChartIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnalyticsContainer(
      child: Row(
        children: widget.teams.isEmpty
            ? [
                Expanded(
                  child: AnalyticsText.dataTitle(
                    'Please select a team in order to see charts.',
                  ),
                ),
              ]
            : [
                Expanded(
                  flex: 40,
                  child: CarouselSlider(
                    items: List.generate(
                      AnalyticsLineChart.charts.length,
                      (index) => _buildChart(index),
                    ),
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      scrollDirection: Axis.vertical,
                      aspectRatio: 1.0,
                      viewportFraction: 1.0,
                      animateToClosest: false,
                      onPageChanged: (index, reason) => setState(() {
                        _currentChartIndex = index;
                      }),
                    ),
                  ),
                ),
                const EmptyExpanded(flex: 1),
                Expanded(
                  flex: 2,
                  child: DotsIndicator(
                    dotsCount: AnalyticsLineChart.charts.length,
                    axis: Axis.vertical,
                    position: _currentChartIndex.toDouble(),
                    decorator: const DotsDecorator(),
                  ),
                ),
              ],
      ),
    );
  }

  Widget _buildChart(int chartIndex) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0) * AnalyticsApp.size,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onVerticalDragEnd: (details) {
            final velocity = details.primaryVelocity ?? 0.0;

            // Swipe up - go one chart down
            if (velocity < -500.0) {
              setState(() {
                if (_currentChartIndex ==
                    AnalyticsLineChart.charts.length - 1) {
                  _currentChartIndex = 0;
                } else {
                  _currentChartIndex += 1;
                }
              });
            }
            // Swipe down - go one chart up
            else if (velocity > 500.0) {
              setState(() {
                if (_currentChartIndex == 0) {
                  _currentChartIndex = AnalyticsLineChart.charts.length - 1;
                } else {
                  _currentChartIndex -= 1;
                }
              });
            }
          },
          child: widget.chartType == AnalyticsChartType.line
              ? AnalyticsLineChart(
                  data: widget.data,
                  chartIndex: _currentChartIndex,
                  teams: widget.teams,
                )
              : AnalyticsLineChart(
                  data: widget.data,
                  chartIndex: _currentChartIndex,
                  teams: widget.teams,
                ),
        ),
      );
}
