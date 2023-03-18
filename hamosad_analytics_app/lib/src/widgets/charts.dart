import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsChartData {}

class AnalyticsLineChart extends StatefulWidget {
  static final List<LineChartBarData Function(int)> charts = [
    (team) => LineChartBarData(),
    (team) => LineChartBarData(),
  ];

  const AnalyticsLineChart({Key? key, required this.chartIndex})
      : super(key: key);

  final int chartIndex;

  @override
  State<AnalyticsLineChart> createState() => _AnalyticsLineChartState();
}

class _AnalyticsLineChartState extends State<AnalyticsLineChart> {
  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData());
  }
}
