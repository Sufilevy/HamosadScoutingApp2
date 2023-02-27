import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/app.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/models.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

enum HorizontalDirection { left, right }

class TeamDropoffsChart extends StatefulWidget {
  const TeamDropoffsChart({
    Key? key,
    required this.dropoffs,
  }) : super(key: key);

  final PiecesDropoffsStat dropoffs;

  @override
  State<TeamDropoffsChart> createState() => _TeamDropoffsChartState();
}

class _TeamDropoffsChartState extends State<TeamDropoffsChart> {
  late final List<Widget> _dropoffsGrids = [
    _buildDropoffsGrid(widget.dropoffs.arenaWallGrid),
    _buildDropoffsGrid(widget.dropoffs.coopGrid),
    _buildDropoffsGrid(widget.dropoffs.loadingZoneGrid),
  ];
  int _gridIndex = 1;

  Widget _buildChangeGridButton({
    required VoidCallback onPressed,
    required HorizontalDirection direction,
  }) =>
      IconButton(
        onPressed: () => setState(() {
          onPressed();
        }),
        icon: Icon(
          (direction == HorizontalDirection.left)
              ? Icons.arrow_back_ios_rounded
              : Icons.arrow_forward_ios_rounded,
        ),
        iconSize: 24.0 * AnalyticsApp.size,
        padding: EdgeInsets.zero,
        color: AnalyticsTheme.foreground2,
      );

  Widget _buildPiecePercentage({
    required Piece piece,
    required PiecesStat percentages,
  }) {
    double percentage =
        (piece == Piece.cone) ? percentages.conesRate : percentages.cubesRate;
    return AnalyticsContainer(
      width: 90.0 * AnalyticsApp.size,
      height: 90.0 * AnalyticsApp.size,
      borderRadius: 2.0,
      child: Center(
        child: AnalyticsText.data(
          '${percentage.toStringAsPrecision(3)}%',
          color: piece.color,
        ),
      ),
    );
  }

  Widget _buildTwoPiecesPercentage({
    required PiecesStat percentages,
  }) =>
      AnalyticsContainer(
        width: 90.0 * AnalyticsApp.size,
        height: 90.0 * AnalyticsApp.size,
        borderRadius: 2.0,
        child: Column(
          children: [
            Expanded(
              flex: 21,
              child: Center(
                child: AnalyticsText.data(
                  '${percentages.conesRate.toStringAsPrecision(3)}%',
                  color: AnalyticsTheme.cones,
                ),
              ),
            ),
            AnalyticsDataDivider(
              width: 75.0 * AnalyticsApp.size,
              height: 1.5 * AnalyticsApp.size,
            ),
            Expanded(
              flex: 21,
              child: Center(
                child: AnalyticsText.data(
                  '${percentages.cubesRate.toStringAsPrecision(3)}%',
                  color: AnalyticsTheme.cubes,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildDropoffsGrid(GridDropoffsStat gridDropoffs) =>
      AnalyticsContainer(
        borderRadius: 5.0,
        height: 268.0 * AnalyticsApp.size,
        width: 268.0 * AnalyticsApp.size,
        color: AnalyticsTheme.foreground2,
        border: Border.all(
          color: AnalyticsTheme.foreground2,
          width: 2.0,
        ),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 1.5,
          crossAxisSpacing: 1.5,
          children: [
            _buildPiecePercentage(
              piece: Piece.cone,
              percentages: gridDropoffs.dropoffs[0][0],
            ),
            _buildPiecePercentage(
              piece: Piece.cube,
              percentages: gridDropoffs.dropoffs[0][1],
            ),
            _buildPiecePercentage(
              piece: Piece.cone,
              percentages: gridDropoffs.dropoffs[0][2],
            ),
            _buildPiecePercentage(
              piece: Piece.cone,
              percentages: gridDropoffs.dropoffs[1][0],
            ),
            _buildPiecePercentage(
              piece: Piece.cube,
              percentages: gridDropoffs.dropoffs[1][1],
            ),
            _buildPiecePercentage(
              piece: Piece.cone,
              percentages: gridDropoffs.dropoffs[1][2],
            ),
            _buildTwoPiecesPercentage(percentages: gridDropoffs.dropoffs[2][0]),
            _buildTwoPiecesPercentage(percentages: gridDropoffs.dropoffs[2][1]),
            _buildTwoPiecesPercentage(percentages: gridDropoffs.dropoffs[2][2]),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx < 0.0 && _gridIndex < 2) {
          // Swipe left
          setState(() {
            _gridIndex++;
          });
        } else if (details.velocity.pixelsPerSecond.dx > 0.0 &&
            _gridIndex > 0) {
          // Swipe right
          setState(() {
            _gridIndex--;
          });
        }
      },
      child: AnalyticsContainer(
        color: AnalyticsTheme.background1,
        width: 350.0 * AnalyticsApp.size,
        height: 300.0 * AnalyticsApp.size,
        child: Row(
          children: [
            const EmptyExpanded(flex: 1),
            Expanded(
              flex: 2,
              child: (_gridIndex > 0)
                  ? _buildChangeGridButton(
                      onPressed: () => _gridIndex--,
                      direction: HorizontalDirection.left,
                    )
                  : Container(),
            ),
            const EmptyExpanded(flex: 1),
            Expanded(
              flex: 26,
              child: AnalyticsFadeSwitcher(
                duration: 400.milliseconds,
                child: Container(
                  key: ValueKey(_gridIndex),
                  child: _dropoffsGrids[_gridIndex],
                ),
              ),
            ),
            const EmptyExpanded(flex: 1),
            Expanded(
              flex: 2,
              child: (_gridIndex < 2)
                  ? _buildChangeGridButton(
                      onPressed: () => _gridIndex++,
                      direction: HorizontalDirection.right,
                    )
                  : Container(),
            ),
            const EmptyExpanded(flex: 1),
          ],
        ),
      ),
    );
  }
}
