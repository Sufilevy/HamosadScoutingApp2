import 'package:dartx/dartx.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/app.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/database/analytics_data.dart';
import 'package:hamosad_analytics_app/src/widgets/analytics.dart';

class AnalyticsChartData {}

class AnalyticsLineChart extends StatelessWidget {
  static final List<LineChartData Function(AnalyticsData, List<int>, int)>
      charts = [
    (data, teams, chartIndex) => LineChartData(
          titlesData: FlTitlesData(
            bottomTitles: _axisTitlesFrom(
              (value) => value.toInt().toString(),
              size: 48.0,
            ),
            leftTitles: _axisTitlesFrom(
              (value) => [
                'No data',
                'No\nattempt',
                'Failed',
                'Docked',
                'Engaged',
              ][value.toInt() + 1],
              size: 100.0,
            ),
            rightTitles: _noAxisTitles(),
            topTitles: _noAxisTitles(),
          ),
          lineBarsData: teams.map(
            (teamNumber) {
              final team = data.teamsWithNumber[teamNumber]!;
              return _lineChartDataFrom(
                team.info.number,
                [
                  const FlSpot(0, 3),
                  const FlSpot(1, 1),
                  const FlSpot(2, 0),
                  const FlSpot(4, -1),
                  const FlSpot(5, 2),
                ],
              );
            },
          ).toList(),
        ),
  ];

  static LineChartBarData _lineChartDataFrom(int team, List<FlSpot> spots) =>
      LineChartBarData(
        spots: spots,
        color: AnalyticsTheme.teamNumberToColor[team],
        barWidth: 3.0 * AnalyticsApp.size,
      );

  static AxisTitles _axisTitlesFrom(
    String Function(double) getTitle, {
    required double size,
  }) =>
      AxisTitles(
        sideTitles: SideTitles(
          reservedSize: size * AnalyticsApp.size,
          interval: 1.0,
          showTitles: true,
          getTitlesWidget: (value, meta) => Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 12.0, 8.0) *
                AnalyticsApp.size,
            child: AnalyticsText.dataSubtitle(
              getTitle(value),
              fontSize: 14.0 * AnalyticsApp.size,
              fittedBox: false,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

  static AxisTitles _noAxisTitles() => AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) => Padding(
            padding: const EdgeInsets.all(8.0) * AnalyticsApp.size,
          ),
        ),
      );

  const AnalyticsLineChart({
    Key? key,
    required this.data,
    required this.chartIndex,
    required this.teams,
  }) : super(key: key);

  final AnalyticsData data;
  final int chartIndex;
  final List<int> teams;

  @override
  Widget build(BuildContext context) {
    return teams.isEmpty
        ? AnalyticsText.dataTitle(
            'Please select a team in order to see the charts.',
          )
        : LineChart(
            charts[chartIndex](
              data,
              teams,
              chartIndex,
            ).copyWith(
                backgroundColor: AnalyticsTheme.background2,
                gridData: FlGridData(
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AnalyticsTheme.foreground2.withOpacity(0.6),
                    dashArray: [8, 5],
                    strokeWidth: 1.25 * AnalyticsApp.size,
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: AnalyticsTheme.foreground2.withOpacity(0.6),
                    dashArray: [8, 5],
                    strokeWidth: 1.25 * AnalyticsApp.size,
                  ),
                ),
                borderData: FlBorderData(
                  border: Border.all(
                    width: 2.5 * AnalyticsApp.size,
                    color: AnalyticsTheme.foreground2.withOpacity(0.6),
                  ),
                )),
            swapAnimationDuration: 0.milliseconds,
          );
  }
}
