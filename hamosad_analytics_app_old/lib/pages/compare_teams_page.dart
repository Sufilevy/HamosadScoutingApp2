import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/components.dart';
import 'package:hamosad_analytics_app/constants.dart';
import 'package:hamosad_analytics_app/models.dart';

final List<Color> compareColors = [
  Colors.red,
  Colors.blue,
  Colors.orange,
  Colors.pink,
  Colors.green,
  Colors.purple
];

class CompareTeamsPage extends StatefulWidget {
  const CompareTeamsPage({Key? key}) : super(key: key);

  @override
  State<CompareTeamsPage> createState() => _CompareTeamsPageState();
}

class _CompareTeamsPageState extends State<CompareTeamsPage> {
  final List<Team> _selectedTeams = [];
  final TextEditingController _teamSelectionController =
      TextEditingController();
  final Map<Team, Color> _teamsColors = {};

  Widget selectedTeam(Team team) => FittedBox(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(99)),
            color: Consts.sectionDefultColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 25,
                    color: Consts.secondaryDisplayColor,
                    icon: const Icon(Icons.close),
                    onPressed: () =>
                        setState(() => _selectedTeams.remove(team)),
                  ),
                ),
                Text(
                  team.info.number.toString(),
                  style: TextStyle(color: _teamsColors[team], fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      );

  Widget pointsView() => Column(
        children: const [
          Text(
            'Points',
            style: TextStyle(
              color: Consts.primaryDisplayColor,
              fontSize: 24,
            ),
          ),
          Expanded(
            child: Chart(
              graphs: [
                Graph(
                  color: Colors.red,
                  points: [
                    [0, 0],
                    [1, 3],
                    [2, 7],
                    [3, 4]
                  ],
                ),
              ],
              maxX: 3,
              maxY: 7,
              minX: 0,
              minY: 0,
              fillBelowBar: false,
            ),
          ),
        ],
      );

  Widget pointAutoView() => Column(
        children: const [
          Text(
            'Points Autonomous',
            style: TextStyle(color: Consts.primaryDisplayColor, fontSize: 24),
          ),
        ],
      );

  Widget pointsTeleopView() => Column(
        children: const [
          Text(
            'Points Teleop',
            style: TextStyle(color: Consts.primaryDisplayColor, fontSize: 24),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return AppPage(
      appBar: AppBar(
        title: const Text('Compare Teams'),
        actions: const [AppbarBackButton()],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        child: Column(
          children: [
            TeamSearchBox(
              teams: const [],
              onChange: (Team team) {
                setState(
                  () {
                    if (!_selectedTeams
                            .map((t) => t.info.name)
                            .contains(team.info.name) &&
                        _selectedTeams.length < 6) {
                      _selectedTeams.add(team);
                      _teamsColors[team] = compareColors[_selectedTeams.length];
                    }
                  },
                );
              },
              inputController: _teamSelectionController,
            ),
            const SizedBox(height: 5),
            Wrap(
              direction: Axis.horizontal,
              children: _selectedTeams
                  .map(
                    (t) => Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: selectedTeam(t),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: RoundedSection(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CarouselWithIndicator(
                    widgets: [
                      pointsView(),
                      pointAutoView(),
                      pointsTeleopView(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}