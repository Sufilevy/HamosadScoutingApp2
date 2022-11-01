
import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/components/carousel_with_indicators.dart';
import 'package:hamosad_scouting_app_2/components/charts/base_chart.dart';
import 'package:hamosad_scouting_app_2/components/rounded_section.dart';
import 'package:hamosad_scouting_app_2/components/team_selector.dart';
import 'package:hamosad_scouting_app_2/models/team.dart';

import '../components/app_page.dart';
import '../constants.dart';
import '../models/graph.dart';

class CompareTeamsPage extends StatefulWidget {
  const CompareTeamsPage({ Key? key }) : super(key: key);

  @override
  _CompareTeamsPageState createState() => _CompareTeamsPageState();
}

class _CompareTeamsPageState extends State<CompareTeamsPage> {
  List<Team> selectedTeams = [];
  TextEditingController teamSelectionCntroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppPage(
      appBar: AppBar(title: const Text('Compare Teams')),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
        child: Column(
          children: [
            TeamsSelector(
              teams: [Team(number: 6740, name: 'Glue Gun & Glitter'), Team(number: 3071, name: 'HaMosad')], 
              onChange: (Team team){
                setState(() {
                  selectedTeams.add(team);
                });
              }, 
              inputController: teamSelectionCntroller
            ),
            const SizedBox(height: 5),
            Wrap(
              direction: Axis.horizontal,
              children: List<Widget>.generate(
                selectedTeams.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: selectedTeam(team: selectedTeams[index]),
                )
              )
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
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectedTeam({required Team team}) => FittedBox(
    child: Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(99),
          ),
          color: Consts.sectionDefultColor
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
                icon: const Icon(
                  Icons.close,
                  color: Consts.secondaryDisplayColor,
                  size: 25,
                ),
                onPressed: () {
                  setState(() {
                    selectedTeams.remove(team);
                  });
                },
              ),
            ),
            Text(
              team.number.toString(),
              style: const TextStyle(
                color: Consts.secondaryDisplayColor,
                fontSize: 20
              ),
            )
          ],
        ),
      ),
    ),
  );

  Widget pointsView() => Column(
    children: [
      const Text(
        'Points', 
        style: TextStyle(
          color: Consts.primaryDisplayColor,
          fontSize: 24
        ),
      ),
      Expanded(child: BaseChart(graphs: [Graph(color: Colors.red, points: [[0,0], [1, 3], [2, 7], [3, 4]])], maxX: 3, maxY: 7, minX: 0, minY: 0, fillBelowBar: false,))
    ],
  );

  Widget pointAutoView() => Column(
    children: [
      const Text(
        'Points Autonomous', 
        style: TextStyle(
          color: Consts.primaryDisplayColor,
          fontSize: 24
        ),
      )
    ],
  );

  Widget pointsTeleopView() => Column(
    children: [
      const Text(
        'Points Teleop', 
        style: TextStyle(
          color: Consts.primaryDisplayColor,
          fontSize: 24
        ),
      )
    ],
  );
}