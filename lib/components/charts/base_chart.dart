import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/models/graph.dart';

import '../../Constants.dart';

class BaseChart extends StatelessWidget {
  const BaseChart({
    required this.graphs,
    required this.maxX,
    required this.maxY,
    required this.minX,
    required this.minY,
    this.yAxisTitles,
    this.getToolipItems
  });

  final List<Graph> graphs;
  final SideTitles? yAxisTitles;
  final List<LineTooltipItem?> Function(List<LineBarSpot>)? getToolipItems;
  final double maxX;
  final double minX;
  final double maxY;
  final double minY;

  @override
  Widget build(BuildContext context){
    return LineChart(
      LineChartData(
        minX: minX,
        maxX: maxX,
        minY: minY,
        maxY: maxY,
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            fitInsideVertically: true,
            fitInsideHorizontally: true,
            getTooltipItems: getToolipItems,
          )
        ),
        lineBarsData: List<LineChartBarData>.generate(
          graphs.length,
          (graphIndx) => LineChartBarData(
            isCurved: false,
            color: graphs[graphIndx].color,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
            ),
            belowBarData: BarAreaData(
              show: true,
              color: graphs[graphIndx].color.withOpacity(0.3),// ???
            ),
            spots: List<FlSpot>.generate(
              graphs[graphIndx].points.length,
              (pointIndx) => FlSpot(graphs[graphIndx].points[pointIndx][0], graphs[graphIndx].points[pointIndx][1])
            )
          )
        ),
        gridData: FlGridData(
          verticalInterval: 1,
          horizontalInterval: 1,
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (final double value) {
            return FlLine(
              color: Consts.primaryDisplayColor,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (final double value) {
            return FlLine(
              color: Consts.primaryDisplayColor,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) => Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Text(
                  value.toString(),
                  style: const TextStyle(
                    color: Consts.primaryDisplayColor,
                ),
            ),
              )
          )),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) => Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  value.toString(),
                  style: const TextStyle(
                    color: Consts.primaryDisplayColor,
                ),
            ),
              )
          )),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Consts.primaryDisplayColor, width: 1),
        )
      )
    );
  }
}