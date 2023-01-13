import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/pages.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({Key? key}) : super(key: key);

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return AnalyticsPage(
      title: _title,
      body: _body,
    );
  }

  Widget get _title => Row(
        children: [
          Expanded(
            flex: 2,
            child: SearchBar(
              onSubmitted: (query) => setState(() {
                _searchQuery = query;
              }),
            ),
          ),
          const Expanded(
            flex: 8,
            child: Text('Hey'),
          ),
        ],
      );

  Widget get _body => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text('Hey'),
        ],
      );
}
