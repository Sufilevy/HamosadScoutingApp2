import 'dart:math' as math;

import 'package:dartx/dartx.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '/models/report/report_model.dart';
import '/pages/compare/charts.dart';
import '/services/utilities.dart';
import '/theme.dart';
import '/widgets/colors.dart';
import '/widgets/padding.dart';
import '/widgets/text.dart';

typedef TeamsWithReports = Map<String, List<Report>>;

class AnalyticsChart extends StatelessWidget {
  AnalyticsChart({super.key, required this.dataFromReport, required this.teamsWithReports});

  final DataFromReport dataFromReport;
  final TeamsWithReports teamsWithReports;

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenSize.width;
    final maxWidth = maxChartWidth(screenWidth, teamsWithReports);

    return Scrollbar(
      controller: _scrollController,
      interactive: maxWidth > screenWidth - 32,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(maxHeight: 400, maxWidth: maxWidth),
          child: LineChart(
            LineChartData(
              backgroundColor: AnalyticsTheme.background2,
              lineBarsData: _lineBarsData,
              titlesData: _titlesData,
              borderData: _borderData,
              gridData: _gridData,
              lineTouchData: _lineTouchData,
            ),
            curve: Curves.easeOut,
          ),
        ),
      ),
    );
  }

  static double maxChartWidth(double screenWidth, TeamsWithReports teamsWithReports) {
    const reportWidth = 100.0;
    final minWidth = screenWidth - 32;

    final maxReportsCount = teamsWithReports.mapEntries((entry) => entry.value.length).max() ?? 0;

    return math.max(minWidth, reportWidth * maxReportsCount);
  }

  List<LineChartBarData> get _lineBarsData {
    return teamsWithReports.mapEntries(
      (entry) {
        final MapEntry(key: teamNumber, value: reports) = entry;

        return LineChartBarData(
          color: TeamInfo.fromNumber(teamNumber).color,
          isCurved: true,
          curveSmoothness: 0.3,
          preventCurveOverShooting: true,
          preventCurveOvershootingThreshold: 20.0,
          barWidth: 3.5 * AnalyticsTheme.appSizeRatio,
          spots: reports
              .mapIndexed((index, report) => FlSpot(index.toDouble(), dataFromReport(report)))
              .toList(),
        );
      },
    ).toList();
  }

  FlTitlesData get _titlesData {
    final emptySide = AxisTitles(
      sideTitles: SideTitles(
        reservedSize: 16 * AnalyticsTheme.appSizeRatio,
        showTitles: true,
        getTitlesWidget: (value, meta) => Container(),
      ),
    );

    return FlTitlesData(
      rightTitles: emptySide,
      topTitles: emptySide,
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40 * AnalyticsTheme.appSizeRatio,
          getTitlesWidget: (value, meta) {
            final valueInt = value.toInt();
            if (valueInt == value) {
              final diff = meta.max - meta.min;
              if ((diff > 30 && value % 10 != 0) ||
                  (meta.appliedInterval == 1 && diff > 5 && valueInt % 2 == 0)) {
                return Container();
              }

              return dataSubtitleText(
                meta.formattedValue,
              ).padSymmetric(horizontal: 8);
            }
            return Container();
          },
        ),
      ),
      bottomTitles: emptySide,
      // Uncomment for bottom titles
      // bottomTitles: AxisTitles(
      //   sideTitles: SideTitles(
      //     showTitles: true,
      //     interval: 1,
      //     reservedSize: 32 * AnalyticsTheme.appSizeRatio,
      //     getTitlesWidget: (value, meta) => dataSubtitleText(value.toInt() + 1).padTop(2),
      //   ),
      // ),
    );
  }

  FlBorderData get _borderData {
    return FlBorderData(
      border: Border.all(
        color: AnalyticsTheme.foreground2,
        width: 1.5,
        strokeAlign: BorderSide.strokeAlignInside,
      ),
    );
  }

  FlGridData get _gridData {
    const gridLine = FlLine(
      color: AnalyticsTheme.foreground2,
      strokeWidth: 0.4,
      dashArray: [6, 8],
    );

    return FlGridData(
      verticalInterval: 1,
      getDrawingVerticalLine: (value) => gridLine,
      getDrawingHorizontalLine: (value) => gridLine,
    );
  }

  LineTouchData get _lineTouchData {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: AnalyticsTheme.background2,
        fitInsideHorizontally: true,
        fitInsideVertically: true,
        getTooltipItems: _tooltipsItems,
        tooltipBorder: const BorderSide(
          color: AnalyticsTheme.background3,
          width: 1.0,
        ),
      ),
    );
  }

  List<LineTooltipItem> _tooltipsItems(List<LineBarSpot> touchedSpots) {
    Color teamColorToTextColor(Color color) => color.lighten((1.0 - color.computeLuminance()) / 4);

    return touchedSpots.map((LineBarSpot touchedSpot) {
      return LineTooltipItem(
        touchedSpot.y >= 100
            ? touchedSpot.y.floor().toString()
            : touchedSpot.y.toStringAsPrecision(2).removeSuffix('.0'),
        AnalyticsTheme.dataSubtitleStyle.copyWith(
          color: teamColorToTextColor(touchedSpot.bar.color ?? AnalyticsTheme.foreground1),
          fontWeight: FontWeight.bold,
        ),
      );
    }).toList();
  }
}
