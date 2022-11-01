
import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/components/team_selector.dart';
import 'package:hamosad_scouting_app_2/models/team.dart';

import '../components/app_page.dart';

class TeamDetailsPage extends StatefulWidget {
  const TeamDetailsPage({ Key? key }) : super(key: key);

  @override
  _TeamDetailsPageState createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends State<TeamDetailsPage> {
  TextEditingController teamSelectionCntroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppPage(
      appBar: AppBar(title: const Text('Team Details')),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        child: Column(
          children: [
            TeamsSelector(
              teams: [Team(number: 6740, name: 'Glue Gun & Glitter'), Team(number: 3071, name: 'HaMosad')], 
              onChange: (Team team){}, 
              inputController: teamSelectionCntroller
            )
          ],
        ),
      ),
    );
  }
}