import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class AnalyticsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AnalyticsAppBar({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => Size.fromHeight(55.0 * AnalyticsTheme.appSizeRatio);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: navigationTitleText(title),
      leading: _buildMenuButton(context),
      leadingWidth: 66.0 * AnalyticsTheme.appSizeRatio,
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return pad(
      left: 20.0,
      top: 6.0,
      bottom: 6.0,
      IconButton(
        iconSize: 24.0 * AnalyticsTheme.appSizeRatio,
        icon: const FaIcon(
          FontAwesomeIcons.barsStaggered,
        ),
        onPressed: Scaffold.of(context).openDrawer,
      ),
    );
  }
}
