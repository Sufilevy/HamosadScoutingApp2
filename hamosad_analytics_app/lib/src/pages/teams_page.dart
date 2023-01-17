import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/pages.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

const List<String> _defaultTeamData = [
  'Name',
  'Rank',
  'Win Rate',
  'Average Score'
];

class TeamsPage extends StatefulWidget {
  const TeamsPage({Key? key}) : super(key: key);

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  String _searchQuery = '';
  bool isSortingDescending = true;
  final List<String> _teamData = _defaultTeamData;
  String _sortByKey = 'Rank';

  void _clearFilters() {}

  @override
  Widget build(BuildContext context) {
    return AnalyticsPage(
      spacing: 10.0,
      verticalPadding: 20.0,
      title: _title,
      body: _body,
    );
  }

  Widget get _title => Row(
        children: [
          Expanded(
            flex: 30,
            child: SearchBar(
              onSubmitted: (query) => setState(() {
                _searchQuery = query;
              }),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            flex: 30,
            child: DropdownButton(
              value: _sortByKey,
              items: _teamData
                  .map((sortKey) => DropdownMenuItem(child: Text(sortKey)))
                  .toList(),
              onChanged: (newKey) => setState(() {
                _sortByKey = newKey;
              }),
            ),
          ),
          const SizedBox(width: 10.0),
          AnalyticsContainer(
            height: 50.0,
            width: 50.0,
            child: IconButton(
              splashRadius: 1.0,
              onPressed: () => setState(() {
                isSortingDescending = !isSortingDescending;
              }),
              icon: RotatedBox(
                quarterTurns: 3,
                child: SvgPicture.asset(
                  isSortingDescending
                      ? 'assets/svg/sort_descending.svg'
                      : 'assets/svg/sort_ascending.svg',
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            flex: 13,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  AnalyticsTheme.background2,
                ),
                fixedSize: MaterialStateProperty.all(
                  const Size.fromHeight(50.0),
                ),
              ),
              onPressed: _clearFilters,
              child: AnalyticsText.dataTitle(
                'Clear Filters',
                color: AnalyticsTheme.foreground2,
              ),
            ),
          ),
        ],
      );

  Widget get _body => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Search query: $_searchQuery'),
        ],
      );
}
