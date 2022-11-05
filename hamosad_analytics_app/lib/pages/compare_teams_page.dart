import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/components/carousel_with_indicators.dart';
import 'package:hamosad_analytics_app/components/chart.dart';
import 'package:hamosad_analytics_app/components/rounded_section.dart';
import 'package:hamosad_analytics_app/models/team.dart';

import '../components/app_page.dart';
import '../components/team_search_box.dart';
import '../constants.dart';

final List<Color> compareColors = [Colors.red, Colors.blue, Colors.orange, Colors.pink, Colors.green, Colors.purple]; 

class CompareTeamsPage extends StatefulWidget {
  const CompareTeamsPage({ Key? key }) : super(key: key);

  @override
  _CompareTeamsPageState createState() => _CompareTeamsPageState();
}

class _CompareTeamsPageState extends State<CompareTeamsPage> {
  List<Team> selectedTeams = [];
  TextEditingController teamSelectionCntroller = TextEditingController();
  Map<Team, Color> teamsColors = {};

  @override
  Widget build(BuildContext context) {
    return AppPage(
      appBar: AppBar(
        title: const Text('Compare Teams'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
            ),
          )
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        child: Column(
          children: [
            TeamSearchBox(
              teams: [Team(number: 6740, name: 'Glue Gun & Glitter'), Team(number: 3071, name: 'HaMosad')], 
              onChange: (Team team){
                setState(() {
                  if (!List<String>.generate(selectedTeams.length, (index) => selectedTeams[index].name).contains(team.name) && selectedTeams.length < 6) {
                    selectedTeams.add(team);
                    teamsColors[team] =compareColors[selectedTeams.length];
                  }
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
              style: TextStyle(
                color: teamsColors[team],
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
      Expanded(child: Chart(graphs: [Graph(color: Colors.red, points: [[0,0], [1, 3], [2, 7], [3, 4]])], maxX: 3, maxY: 7, minX: 0, minY: 0, fillBelowBar: false,))
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