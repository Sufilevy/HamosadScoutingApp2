import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/components.dart';
import 'package:hamosad_analytics_app/constants.dart';
import 'package:hamosad_analytics_app/models.dart';
import 'package:hamosad_analytics_app/pages.dart';

class TeamListPage extends StatefulWidget {
  const TeamListPage({Key? key}) : super(key: key);

  @override
  State<TeamListPage> createState() => _TeamListPageState();
}

class _TeamListPageState extends State<TeamListPage> {
  List<Team> teamList = [];
  int Function(Team a, Team b)? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      appBar: AppBar(
          title: const Text('Team List'), actions: const [AppbarBackButton()]),
      body: Column(children: [
        filterSelector(),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          child: teamListWidget(),
        ),
      ]),
    );
  }

  Widget filterSelector() => SelectionButton<int Function(Team a, Team b)>(
        hint: const Text('Choose sorting filter',
            style: TextStyle(
                color: Consts.secondaryDisplayColor,
                fontSize: 24,
                fontFamily: Consts.defaultFontFamily)),
        textStyle: const TextStyle(
            color: Consts.secondaryDisplayColor,
            fontSize: 24,
            fontFamily: Consts.defaultFontFamily),
        borderRadius: 0,
        selectedValue: selectedFilter,
        items: {
          const Text('name'): nameFilter,
          const Text('number'): numberFilter
        },
        onChange: (int Function(Team a, Team b)? newFilter) {
          setState(() {
            selectedFilter = newFilter!;
          });
        },
      );

  Widget teamListWidget() => ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: teamList.length,
        itemBuilder: (context, index) {
          if (selectedFilter != null) {
            teamList.sort(selectedFilter);
          }
          Team team = teamList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 6, top: 6),
            child: InkWell(
              onTap: () {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TeamDetailsPage(initTeam: team)));
                });
              },
              child: RoundedSection(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Consts.primaryDisplayColor,
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    child: Text('${team.number.toString()} ${team.name}',
                        style: const TextStyle(
                            color: Consts.sectionDefultColor, fontSize: 20)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Wrap(
                      spacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            'number: ${team.number.toString()}',
                            style: const TextStyle(
                                color: Consts.primaryDisplayColor,
                                fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Text(
                            'name: ${team.name.toString()}',
                            style: const TextStyle(
                                color: Consts.primaryDisplayColor,
                                fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
            ),
          );
        },
      );

  int nameFilter(Team a, Team b) {
    return a.name.compareTo(b.name);
  }

  int numberFilter(Team a, Team b) {
    if (a.number < b.number) {
      return -1;
    } else if (a.number > b.number) {
      return 1;
    } else {
      return 0;
    }
  }
}
