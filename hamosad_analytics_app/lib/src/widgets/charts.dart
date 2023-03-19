import 'package:dartx/dartx.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/app.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/database.dart';
import 'package:hamosad_analytics_app/src/models.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

class AnalyticsChartData {}

class AnalyticsLineChart extends StatelessWidget {
  static final List<LineChartData Function(AnalyticsData, List<int>)> charts = [
    (data, teams) => _chartFrom(
          data,
          teams,
          'Total Game Pieces',
          (report) => report.totalDropoffs,
        ),
    (data, teams) => _chartFrom(
          data,
          teams,
          'Total Cones',
          (report) => report.totalCones,
        ),
    (data, teams) => _chartFrom(
          data,
          teams,
          'Total Cubes',
          (report) => report.totalCubes,
        ),
    (data, teams) => _chartFrom(
          data,
          teams,
          'Total Auto Game Pieces',
          (report) => report.autoDropoffs,
        ),
    (data, teams) => _chartFrom(
          data,
          teams,
          'Total Teleop & Endgame Game Pieces',
          (report) => report.teleopAndEndgameDropoffs,
        ),
    (data, teams) => _chartFrom(
          data,
          teams,
          'Total High Game Pieces',
          (report) => report.totalHighDropoffs,
        ),
    (data, teams) => _chartFrom(
          data,
          teams,
          'Total Mid Game Pieces',
          (report) => report.totalMidDropoffs,
        ),
    (data, teams) => _chartFrom(
          data,
          teams,
          'Total Low Game Pieces',
          (report) => report.totalLowDropoffs,
        ),
    (data, teams) => _chartFrom(
          data,
          teams,
          'Auto Climb',
          (report) => report.auto.climb?.state.index ?? 0,
          getTitle: (value) => [
            'No\nattempt',
            'Failed',
            'Docked',
            'Engaged',
          ][value.toInt()],
          titlesSize: 100.0,
          maxY: 3,
        ),
    (data, teams) => _chartFrom(
          data,
          teams,
          'Endgame Climb',
          (report) => report.endgame.climb?.state.index ?? 0,
          getTitle: (value) => [
            'No\nattempt',
            'Failed',
            'Docked',
            'Engaged',
          ][value.toInt()],
          titlesSize: 100.0,
          maxY: 3,
        ),
  ];

  static LineChartData _chartFrom(
    AnalyticsData data,
    List<int> teams,
    String title,
    int Function(Report) getData, {
    String Function(double)? getTitle,
    double? titlesSize,
    double? maxY,
  }) =>
      LineChartData(
        minY: 0,
        maxY: maxY,
        titlesData: _titlesDataFrom(
          title,
          getTitle ?? (value) => value.toString(),
          size: titlesSize,
        ),
        lineBarsData: teams.map(
          (teamNumber) {
            final team = data.teamsWithNumber[teamNumber]!;
            return _lineChartDataFrom(
              team.info.number,
              team.reports,
              getData,
            );
          },
        ).toList(),
      );

  static LineChartBarData _lineChartDataFrom(
    int team,
    List<Report> reports,
    int Function(Report) getData,
  ) =>
      LineChartBarData(
        isCurved: true,
        curveSmoothness: 0.25 * AnalyticsApp.size,
        preventCurveOverShooting: true,
        spots: reports
            .mapIndexed(
              (index, report) => FlSpot(
                index + 1,
                getData(report).toDouble(),
              ),
            )
            .toList(),
        color: AnalyticsTheme.teamNumberToColor[team],
        barWidth: 3.0 * AnalyticsApp.size,
      );

  static _titlesDataFrom(
    String title,
    String Function(double) getTitle, {
    double? size,
  }) =>
      FlTitlesData(
        bottomTitles: _axisTitlesFrom(
          (value) => value.toInt().toString(),
          48.0,
        ),
        leftTitles: _axisTitlesFrom(getTitle, size ?? 48.0),
        rightTitles: _noAxisTitles(),
        topTitles: AxisTitles(
          axisNameWidget: AnalyticsText.dataTitle(title),
          axisNameSize: 100.0 * AnalyticsApp.size,
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  static AxisTitles _axisTitlesFrom(
    String Function(double) getTitle,
    double size,
  ) =>
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
    return AnalyticsFadeSwitcher(
      child: LineChart(
        key: ValueKey(chartIndex),
        charts[chartIndex](
          data,
          teams,
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
      ),
    );
  }
}
