
import 'package:flutter/material.dart';

import '../components/app_page.dart';

class TeamDetailsPage extends StatefulWidget {
  const TeamDetailsPage({ Key? key }) : super(key: key);

  @override
  _TeamDetailsPageState createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends State<TeamDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      appBar: AppBar(title: const Text('Team Details')),
      body: Container(),
    );
  }
}