
import 'package:flutter/material.dart';

import '../components/app_page.dart';

class TeamListPage extends StatefulWidget {
  const TeamListPage({ Key? key }) : super(key: key);

  @override
  _TeamListPageState createState() => _TeamListPageState();
}

class _TeamListPageState extends State<TeamListPage> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      appBar: AppBar(title: const Text('Team List')),
      body: Container(),
    );
  }
}