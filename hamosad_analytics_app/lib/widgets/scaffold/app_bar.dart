import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class AnalyticsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AnalyticsAppBar({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => Size.fromHeight(60.0 * AnalyticsTheme.appSizeRatio);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: navigationText(title).padTop(8.0),
      leading: _buildMenuButton(context),
      leadingWidth: 60.0 * AnalyticsTheme.appSizeRatio,
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return Container(
      child: IconButton(
        icon: const FaIcon(FontAwesomeIcons.barsStaggered),
        onPressed: Scaffold.of(context).openDrawer,
      ).pad(left: 20.0, top: 10.0, bottom: 8.0),
    );
  }
}
