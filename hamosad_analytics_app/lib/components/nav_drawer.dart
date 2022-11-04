import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/pages/compare_teams_page.dart';
import 'package:hamosad_analytics_app/pages/team_details_page.dart';
import 'package:hamosad_analytics_app/pages/team_list_page.dart';

import '../constants.dart';
import '../pages/report_details_page.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({required this.onChange, super.key});

  final Function(Widget) onChange;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 19, 23, 34),
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(10), child: title()),
          navMenu()
        ],
      ),
    );
  }

  Widget title() => const Text('Analytics',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Consts.secondaryDisplayColor,
        fontSize: 32,
      ));

  Widget navMenu() => Expanded(
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Consts.defaultBorderRadiusSize),
              topRight: Radius.circular(Consts.defaultBorderRadiusSize)),
          child: Container(
              color: const Color.fromARGB(255, 27, 33, 48),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 20, right: 20),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    menuCategoryHeader('Teams'),
                    pageNavItem(const TeamDetailsPage(), 'Team Details',
                        Icons.info_outline),
                    pageNavItem(const TeamListPage(), 'Team List', Icons.list),
                    pageNavItem(const CompareTeamsPage(), 'Compare Teams',
                        Icons.compare_arrows),
                    menuCategoryHeader('Reports'),
                    //pageNavItem(const CompareTeamsPage(), 'Reports Status', Icons.info_outline),
                    pageNavItem(const ReportDetailsPage(), 'Report Details',
                        Icons.info_outline),
                  ],
                ),
              ))));

  Widget menuCategoryHeader(String title) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const Divider(
            thickness: 1,
            color: Colors.white,
          )
        ],
      );

  Widget pageNavItem(Widget page, String title, IconData icon) => ListTile(
        contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
        title: Text(
          title,
          style:
              const TextStyle(color: Consts.primaryDisplayColor, fontSize: 26),
        ),
        leading: FittedBox(
            child: Icon(
          icon,
          color: Consts.primaryDisplayColor,
          size: 40,
        )),
        onTap: () => onChange(page),
      );
}
