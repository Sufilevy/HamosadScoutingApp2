import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/components.dart';
import 'package:hamosad_analytics_app/constants.dart';
import 'package:hamosad_analytics_app/models.dart';

class TeamDetailsPage extends StatefulWidget {
  const TeamDetailsPage({super.key, this.initTeam});

  final Team? initTeam;

  @override
  State<TeamDetailsPage> createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends State<TeamDetailsPage> {
  TextEditingController teamSelectionCntroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Team? team = widget.initTeam;
    if (team != null) {
      teamSelectionCntroller.text = '${team.number} ${team.name}';
    }

    return AppPage(
      appBar: AppBar(
        title: const Text('Team Details'),
        actions: const [AppbarBackButton()]
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        child: Column(
          children: [
            TeamSearchBox(
                teams: [
                  Team(number: 6740, name: 'Glue Gun & Glitter'),
                  Team(number: 3071, name: 'HaMosad')
                ],
                onChange: (Team newTeam) {
                  team = newTeam;
                },
                inputController: teamSelectionCntroller),
            const SizedBox(height: 5),
            Expanded(
              child: RoundedSection(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CarouselWithIndicator(
                  widgets: [general(), autonomous(), teleop(), comments()],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget general() => Column(
        children: const [
          Text(
            'General',
            style: TextStyle(color: Consts.primaryDisplayColor, fontSize: 24),
          ),
          Expanded(
              child: Chart(
            graphs: [
              Graph(color: Colors.red, points: [
                [0, 0],
                [1, 3],
                [2, 7],
                [3, 4]
              ])
            ],
            maxX: 3,
            maxY: 7,
            minX: 0,
            minY: 0,
            fillBelowBar: true,
          ))
        ],
      );

  Widget teleop() => Column(
        children: const [
          Text(
            'Teleop',
            style: TextStyle(color: Consts.primaryDisplayColor, fontSize: 24),
          )
        ],
      );

  Widget autonomous() => Column(
        children: const [
          Text(
            'Autonomous',
            style: TextStyle(color: Consts.primaryDisplayColor, fontSize: 24),
          )
        ],
      );

  Widget comments() => Column(
        children: [
          const Text(
            'Comments',
            style: TextStyle(color: Consts.primaryDisplayColor, fontSize: 24),
          ),
          SingleChildScrollView(
            child: Column(
              children: const [
                Divider(
                  color: Consts.primaryDisplayColor,
                  thickness: 1,
                ),
                Text(
                  'Carriage quitting securing be appetite it declared. High eyes kept so busy feel call in. Would day nor ask walls known. But preserved advantage are but and certainty earnestly enjoyment. Passage weather as up am exposed. And natural related man subject. Eagerness get situation his was delighted.',
                  style: TextStyle(color: Consts.primaryDisplayColor),
                ),
                Divider(
                  color: Consts.primaryDisplayColor,
                  thickness: 1,
                )
              ],
            ),
          )
        ],
      );
}
