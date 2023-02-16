import 'package:flutter/material.dart';
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
        iconSize: 14.0,
        color: AnalyticsTheme.foreground2,
        splashRadius: 1.0,
      );

  Widget _buildPiecePercentage({
    required Piece piece,
    required double percentage,
  }) =>
      Container();

  Widget _buildTwoPiecesPercentage() => Container();

  Widget _buildDropoffsGrid(GridDropoffsStat gridDropoffs) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: AnalyticsTheme.foreground2,
        ),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 1.5,
          crossAxisSpacing: 1.5,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AnalyticsContainer(
      color: AnalyticsTheme.background1,
      width: 320.0,
      height: 300.0,
      child: Row(
        children: [
          const EmptyExpanded(flex: 10),
          Expanded(
            flex: 10,
            child: (_gridIndex > 0)
                ? _buildChangeGridButton(
                    onPressed: () => _gridIndex -= 1,
                    direction: HorizontalDirection.left,
                  )
                : Container(),
          ),
          const EmptyExpanded(flex: 10),
          Expanded(
            flex: 260,
            child: _dropoffsGrids[_gridIndex],
          ),
          const EmptyExpanded(flex: 10),
          Expanded(
            flex: 10,
            child: (_gridIndex < 2)
                ? _buildChangeGridButton(
                    onPressed: () => _gridIndex += 1,
                    direction: HorizontalDirection.right,
                  )
                : Container(),
          ),
          const EmptyExpanded(flex: 10),
        ],
      ),
    );
  }
}
