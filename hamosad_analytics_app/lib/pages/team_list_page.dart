import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/components/selector.dart';
import 'package:hamosad_analytics_app/pages/team_details_page.dart';

import '../Constants.dart';
import '../components/app_page.dart';
import '../components/rounded_section.dart';
import '../models/team.dart';

class TeamListPage extends StatefulWidget {
  const TeamListPage({Key? key}) : super(key: key);

  @override
  State<TeamListPage> createState() => _TeamListPageState();
}

class _TeamListPageState extends State<TeamListPage> {
  List<Team> teamList = [
    Team(number: 6740, name: 'Glue Gun & Glitter'),
    Team(number: 3071, name: 'HaMosad')
  ];
  int Function(Team a, Team b)? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      appBar: AppBar(title: const Text('Team List')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: teamListWidget(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sorting filter:',
                  style: TextStyle(
                      color: Consts.secondaryDisplayColor,
                      fontSize: 14,
                      fontFamily: Consts.defaultFontFamily),
                ),
                const SizedBox(height: 3),
                filterSelector(),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget filterSelector() => Selector<int Function(Team a, Team b)>(
        hint: const Text('Choose sorting filter',
            style: TextStyle(
                color: Consts.secondaryDisplayColor,
                fontSize: 24,
                fontFamily: Consts.defaultFontFamily)),
        textStyle: const TextStyle(
            color: Consts.secondaryDisplayColor,
            fontSize: 24,
            fontFamily: Consts.defaultFontFamily),
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
            padding: const EdgeInsets.only(bottom: 4, top: 4),
            child: InkWell(
              onTap: () {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TeamDetailsPage(initTeam: team)));
                });
              },
              child: RoundedSection(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${team.name} ${team.name}',
                        style: const TextStyle(
                            color: Consts.secondaryDisplayColor, fontSize: 16)),
                    Wrap(
                      spacing: 8,
                      children: [
                        Text(
                          'number: ${team.number.toString()}',
                          style: const TextStyle(
                              color: Consts.primaryDisplayColor, fontSize: 18),
                        ),
                        Text(
                          'name: ${team.name.toString()}',
                          style: const TextStyle(
                              color: Consts.primaryDisplayColor, fontSize: 18),
                        )
                      ],
                    ),
                  ],
                ),
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
